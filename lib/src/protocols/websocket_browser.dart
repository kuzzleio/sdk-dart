import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:kuzzle/src/kuzzle/response.dart';

import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import 'abstract.dart';
import 'events.dart';

class KuzzleWebSocket extends KuzzleProtocol {
  KuzzleWebSocket(
    Uri uri, {
    bool autoReconnect = true,
    Duration reconnectionDelay = const Duration(seconds: 1),
    int reconnectionAttempts = 10,
    this.pingInterval,
  }) : super(uri,
            autoReconnect: autoReconnect,
            reconnectionDelay: reconnectionDelay,
            reconnectionAttempts: reconnectionAttempts);

  WebSocket? _webSocket;
  StreamSubscription? _subscription;
  Duration? pingInterval;

  @override
  Future<void> protocolConnect() async {
    if (connectionAborted) {
      return;
    }

    final _connected = Completer();
    final url = '${uri.scheme}://${uri.host}:${uri.port}';

    _webSocket = WebSocket(url);

    await _subscription?.cancel();
    _subscription = null;

    _subscription = _webSocket!.onMessage.listen(_handlePayload);

    final onErrorSubscription = _webSocket!.onError.listen((Event event) {
      if (_connected.isCompleted) {
        return;
      }

      _connected.completeError(KuzzleError(
          'sdk:network:error', 'Unable to connect to ${uri.toString()}'));
    });

    final onCloseSubscription = _webSocket!.onClose.listen((Event event) {
      if (_connected.isCompleted) {
        return;
      }

      _connected.completeError(KuzzleError(
          'sdk:network:error', 'Unable to connect to ${uri.toString()}'));
    });

    _webSocket!.onOpen.listen((_) {
      if (_connected.isCompleted) {
        return;
      }
      onErrorSubscription.cancel();
      onCloseSubscription.cancel();

      _webSocket!.onError.listen(_handleError);
      _webSocket!.onClose.listen(_handleDone);

      _connected.complete();
    });

    return _connected.future;
  }

  @override
  Future<void> send(KuzzleRequest request) async {
    if (_webSocket != null && _webSocket!.readyState == WebSocket.OPEN) {
      _webSocket!.sendString(json.encode(request));
    }
  }

  @override
  void close() {
    super.close();

    removeAllListeners();

    _subscription?.cancel();
    _subscription = null;

    _webSocket?.close();
    _webSocket = null;
  }

  void _handlePayload(MessageEvent payload) {
    try {
      final _json = json.decode(payload.data as String) as Map<String, dynamic>;
      final response = KuzzleResponse.fromJson(_json);

      if (response.room != null && response.room!.isNotEmpty) {
        emit(ProtocolEvents.NETWORK_ON_RESPONSE_RECEIVED, [response]);
      } else {
        emit(ProtocolEvents.QUERY_ERROR, [response.error, payload]);
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      emit(ProtocolEvents.QUERY_ERROR, [e, payload]);
    }
  }

  void _handleError(Event event) {
    clientNetworkError(event);
  }

  void _handleDone(Event event) {
    clientDisconnected();
  }
}
