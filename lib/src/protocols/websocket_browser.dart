import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:kuzzle/src/kuzzle/response.dart';

import '../kuzzle/request.dart';

import 'abstract.dart';
import 'events.dart';

class KuzzleWebSocket extends KuzzleProtocol {
  KuzzleWebSocket(
    Uri uri, {
    bool autoReconnect = true,
    Duration reconnectionDelay = const Duration(seconds: 1),
    int reconnectionAttempts = 10,
    required this.pingInterval,
  }) : super(uri,
            autoReconnect: autoReconnect,
            reconnectionDelay: reconnectionDelay,
            reconnectionAttempts: reconnectionAttempts);

  WebSocket? _webSocket;
  StreamSubscription? _subscription;
  StreamSubscription? _onErrorSubscription;
  StreamSubscription? _onCloseSubscription;
  Duration pingInterval;
  Timer? pingTimer;

  @override
  Future<void> protocolConnect() async {
    if (connectionAborted) {
      return;
    }

    final _connected = Completer();
    final url = '${uri.scheme}://${uri.host}:${uri.port}';

    _webSocket ??= WebSocket(url);

    await _subscription?.cancel();
    _subscription = null;

    _subscription = _webSocket!.onMessage.listen(_handlePayload);

    pingTimer?.cancel();
    pingTimer = Timer.periodic(pingInterval, (timer) {
      if (_webSocket != null && _webSocket!.readyState == WebSocket.OPEN) {
        _webSocket!.sendString('{"p":1}');
      } else {
        timer.cancel();
      }
    });

    _onErrorSubscription = _webSocket!.onError.listen(_handleError);

    _onCloseSubscription = _webSocket!.onClose.listen(_handleDone);

    _webSocket!.onOpen.listen((_) {
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

    _onErrorSubscription?.cancel();
    _onErrorSubscription = null;

    _onCloseSubscription?.cancel();
    _onCloseSubscription = null;
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
