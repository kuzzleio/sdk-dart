import 'dart:async';
import 'dart:convert';

import 'controllers/abstract.dart';
import 'controllers/auth.dart';
import 'controllers/bulk.dart';
import 'controllers/collection.dart';
import 'controllers/document.dart';
import 'controllers/index.dart';
import 'controllers/realtime.dart';
import 'controllers/security.dart';
import 'controllers/server.dart';
import 'kuzzle/errors.dart';
import 'kuzzle/event_emitter.dart';
import 'kuzzle/request.dart';
import 'kuzzle/response.dart';
import 'protocols/abstract.dart';
import 'protocols/events.dart';

enum OfflineMode { manual, auto }

class _KuzzleQueuedRequest {
  _KuzzleQueuedRequest({
    this.completer,
    this.request,
  }) : queuedAt = DateTime.now();

  Completer<KuzzleResponse> completer;
  KuzzleRequest request;
  DateTime queuedAt;
}

class Kuzzle extends KuzzleEventEmitter {
  Kuzzle(
    this.protocol, {
    this.autoQueue = false,
    this.autoReplay = false,
    this.autoResubscribe = true,
    this.eventTimeout = 200,
    this.offlineMode = OfflineMode.manual,
    this.offlineQueueLoader,
    this.queueFilter,
    this.queueTTL,
    this.queueMaxSize = 500,
    this.replayInterval,
    this.globalVolatile,
  }) {
    if (offlineMode == OfflineMode.auto) {
      autoQueue = true;
      autoReplay = true;
    }

    globalVolatile ??= <String, dynamic>{};
    queueTTL ??= Duration(minutes: 2);
    replayInterval ??= Duration(milliseconds: 10);

    server = ServerController(this);
    bulk = BulkController(this);
    auth = AuthController(this);
    index = IndexController(this);
    collection = CollectionController(this);
    document = DocumentController(this);
    security = SecurityController(this);
    realtime = RealTimeController(this);

    protocol.on(ProtocolEvents.QUERY_ERROR, (error, request) {
      emit(ProtocolEvents.QUERY_ERROR, [error, request]);
    });

    protocol.on(ProtocolEvents.TOKEN_EXPIRED, () {
      jwt = null;
      emit(ProtocolEvents.TOKEN_EXPIRED);
    });

    protocol.on(ProtocolEvents.NETWORK_ON_RESPONSE_RECEIVED, (payload) {
    try {
      final _json = json.decode(payload as String) as Map<String, dynamic>;
      final response = KuzzleResponse.fromJson(_json);

      if (response.room.isNotEmpty) {
        if (!_requests.contains(response.room)) {
          protocol.emit(ProtocolEvents.UNHANDLED_RESPONSE, [response]);
        }
        if (response.error != null && 
          response.error.id == 'security.token.expired') {
            emit(ProtocolEvents.TOKEN_EXPIRED);
        }
        protocol.emit(response.room, [response]);
      } else {
        protocol.emit(ProtocolEvents.UNHANDLED_RESPONSE, [response]);
      }
    } catch (_) {
      protocol.emit(ProtocolEvents.DISCARDED, [payload]);
    }
    });
  }

  ServerController get server => this['server'] as ServerController;
  set server(ServerController _server) => this['server'] = _server;

  AuthController get auth => this['auth'] as AuthController;
  set auth(AuthController _auth) => this['auth'] = _auth;

  BulkController get bulk => this['bulk'] as BulkController;
  set bulk(BulkController _bulk) => this['bulk'] = _bulk;

  IndexController get index => this['index'] as IndexController;
  set index(IndexController _index) => this['index'] = _index;

  DocumentController get document => this['document'] as DocumentController;
  set document(DocumentController _document) => this['document'] = _document;

  SecurityController get security => this['security'] as SecurityController;
  set security(SecurityController _security) => this['security'] = _security;

  RealTimeController get realtime => this['realtime'] as RealTimeController;
  set realtime(RealTimeController _realtime) => this['realtime'] = _realtime;

  CollectionController get collection =>
      this['collection'] as CollectionController;
  set collection(CollectionController _collection) =>
      this['collection'] = _collection;

  /// Protocol used by the SDK
  final KuzzleProtocol protocol;

  final int eventTimeout;
  final OfflineMode offlineMode;
  final Function offlineQueueLoader;
  final Function queueFilter;

  /// Automatically queue all requests during offline mode
  bool autoQueue;

  /// Automatically replay queued requests on a reconnected event
  bool autoReplay;

  /// Automatically renew all subscriptions on a reconnected event
  bool autoResubscribe;

  /// Number of maximum requests kept during offline mode
  int queueMaxSize;

  /// Time a queued request is kept during offline mode, in milliseconds
  Duration queueTTL;

  /// Delay between each replayed requests
  Duration replayInterval;

  /// Token used in requests for authentication
  String jwt;

  /// Common volatile data, will be sent to all future requests
  Map<String, dynamic> globalVolatile;

  final List<String> _requests = List();

  bool get autoReconnect => protocol.autoReconnect;
  set autoReconnect(bool value) {
    protocol.autoReconnect = value;
  }

  final Map<String, KuzzleController> _controllers =
      <String, KuzzleController>{};
  final List<_KuzzleQueuedRequest> _offlineQueue = <_KuzzleQueuedRequest>[];
  bool _queuing = false;

  /// Connects to a Kuzzle instance using the provided host name
  Future<void> connect() {
    if (protocol.isReady()) {
      return Future.value();
    }

    if (protocol.state == KuzzleProtocolState.connecting) {
      final completer = Completer<void>();

      // todo: handle reconnect event
      protocol.once(ProtocolEvents.CONNECT, completer.complete);

      return completer.future;
    }

    if (autoQueue) {
      startQueuing();
    }

    protocol.on(ProtocolEvents.CONNECT, () {
      if (autoQueue) {
        stopQueuing();
      }

      if (autoReplay) {
        playQueue();
      }

      emit(ProtocolEvents.CONNECTED);
    });

    protocol.on(ProtocolEvents.NETWORK_ERROR, (error) {
      if (autoQueue) {
        startQueuing();
      }

      emit(ProtocolEvents.NETWORK_ERROR, [error]);
    });

    protocol.on(ProtocolEvents.DISCONNECT, () {
      _requests.clear();
      emit(ProtocolEvents.DISCONNECTED);
    });

    protocol.on(ProtocolEvents.RECONNECT, () {
      if (autoQueue) {
        stopQueuing();
      }

      if (autoReplay) {
        playQueue();
      }

      if (jwt == null) {
        emit(ProtocolEvents.RECONNECTED);
        return;
      }

      auth.checkToken(jwt).then((result) {
        // shouldn't obtain an error but let's invalidate the token anyway
        if (result['valid'] is! bool && result['valid'] == false) {
          jwt = null;
        }

        emit(ProtocolEvents.RECONNECTED);
      }).catchError((_) {
        jwt = null;
        emit(ProtocolEvents.RECONNECTED);
      });
    });

    protocol.on(ProtocolEvents.DISCARDED, (request) {
      emit(ProtocolEvents.DISCARDED, [request]);
    });

    return protocol.connect();
  }

  /// Disconnects from Kuzzle and invalidate this instance.
  void disconnect() {
    protocol.close();
  }

  /// Starts the requests queuing.
  void startQueuing() {
    _queuing = true;
  }

  /// Stops the requests queuing.
  void stopQueuing() {
    _queuing = false;
  }

  /// Plays the requests queued during offline mode.
  void playQueue() {
    if (protocol.isReady()) {
      _cleanQueue();
      _dequeue();
    }
  }

  /// Empties the offline queue without replaying it.
  void flushQueue() {
    _offlineQueue.clear();
  }

  /// Clean up invalid requests in the queue
  ///
  /// Ensure the `queryTTL` and `queryMaxSize` properties are respected
  void _cleanQueue() {
    final now = DateTime.now();
    var lastDocumentIndex = -1;

    if (!queueTTL.isNegative) {
      lastDocumentIndex = _offlineQueue.lastIndexWhere((queuedRequest) =>
          queuedRequest.queuedAt.add(queueTTL).difference(now).isNegative);

      if (lastDocumentIndex != -1) {
        for (final queuedRequest
            in _offlineQueue.getRange(0, lastDocumentIndex + 1)) {
          _requests.remove(queuedRequest.request.requestId);
          emit(ProtocolEvents.OFFLINE_QUEUE_POP, [queuedRequest.request]);
        }

        _offlineQueue.removeRange(0, lastDocumentIndex + 1);
      }
    }

    if (queueMaxSize > 0 && _offlineQueue.length > queueMaxSize) {
      for (final queuedRequest in _offlineQueue.getRange(
          0, _offlineQueue.length + 1 - queueMaxSize)) {
        emit(ProtocolEvents.OFFLINE_QUEUE_POP, [queuedRequest.request]);
      }

      _offlineQueue.removeRange(0, _offlineQueue.length + 1 - queueMaxSize);
    }
  }

  /// Play all queued requests, in order.
  void _dequeue() {
    void _dequeuingProcess() {
      if (_offlineQueue.isNotEmpty) {
        final queuedRequest = _offlineQueue.first;

        _requests.add(queuedRequest.request.requestId);

        protocol.query(queuedRequest.request).then((response) {
          queuedRequest.completer.complete(response);
        }).catchError((error) {
          queuedRequest.completer.completeError(error);
        });

        emit(ProtocolEvents.OFFLINE_QUEUE_POP, [queuedRequest.request]);
        _offlineQueue.removeAt(0);

        Timer(replayInterval, _dequeuingProcess);
      }
    }

    if (offlineQueueLoader != null) {
      // todo: implement offlineQueueLoader
    }

    _dequeuingProcess();
  }

  // todo: implement query options
  /// Base method used to send read queries to Kuzzle
  ///
  /// This is a low-level method, with offline queue management,
  /// exposed to allow advanced SDK users to bypass high-level methods.
  ///
  /// Takes an optional Map `[options]` with the following properties:
  ///
  /// ```
  ///  final options = {
  ///    'queueable': bool,
  ///    'volatile': Map<String, dynamic>,
  ///  };
  /// ```
  ///
  Future<KuzzleResponse> query(KuzzleRequest request,
      {Map<String, dynamic> volatile, bool queueable = true}) {
    //final _request = KuzzleRequest.fromMap(request);

    // bind volatile data
    request.volatile ??= volatile ?? globalVolatile;

    for (final item in globalVolatile.keys) {
      if (!request.volatile.containsKey(item)) {
        request.volatile[item] = globalVolatile[item];
      }
    }

    request.volatile['sdkInstanceId'] = protocol.id;
    request.volatile['sdkName'] = '2.0.0';

    /*
     * Do not add the token for the checkToken route,
     * to avoid getting a token error when a developer
     * simply wish to verify his token
     */
    if ((jwt != null && jwt.isNotEmpty) &&
        !(request.controller == 'auth' && request.action == 'checkToken')) {
      request.jwt = jwt;
    }

    if (queueFilter != null) {
      // todo: implement queueFilter
    }


    // check queueing
    if (_queuing) {
      if (queueable) {

        final completer = Completer<KuzzleResponse>();
        final queuedRequest = _KuzzleQueuedRequest(
          completer: completer,
          request: request,
        );

        _cleanQueue();

        _offlineQueue.add(queuedRequest);
        emit(ProtocolEvents.OFFLINE_QUEUE_PUSH, [queuedRequest.request]);

        return completer.future;
      }

      emit(ProtocolEvents.DISCARDED, [request]);
      return Future.error(KuzzleError(
          'not_connected',
          'Unable to execute request: not connected to a Kuzzle server.',
        503));
    }

    _requests.add(request.requestId);
    // todo: implement query options
    return protocol.query(request);
  }

  KuzzleController operator [](String accessor) => _controllers[accessor];

  void operator []=(String accessor, KuzzleController controller) {
    assert(_controllers[accessor] == null);

    controller.accessor = accessor;

    _controllers[accessor] = controller;
  }
}
