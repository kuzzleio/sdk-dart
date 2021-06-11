import 'dart:async';
import 'dart:convert';
import 'dart:html';

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

  WebSocket _webSocket;
  StreamSubscription _subscription;
  Duration pingInterval;
  final Completer<void> _connected = Completer();

  @override
  Future<void> protocolConnect() async {
    if (connectionAborted) {
      return;
    }

    final url = '${uri.scheme}://${uri.host}:${uri.port}';

    _webSocket ??= WebSocket(url);

    await _subscription?.cancel();
    _subscription = null;

    _subscription = _webSocket.onMessage.listen(_handlePayload);

    final onErrorSubscription =
        _webSocket.onError.listen(_connected.completeError);

    var onCloseSubscription = _webSocket.onClose.listen((Event event) {
      _connected
          .completeError(KuzzleError('Unable to connect to ${uri.toString()}'));
    });

    _webSocket.onOpen.listen((_) {
      onErrorSubscription.cancel();
      onCloseSubscription.cancel();

      _webSocket.onError.listen(_handleError);
      _webSocket.onClose.listen(_handleDone);

      _connected.complete();
    });

    return _connected.future;
  }

  @override
  Future<void> send(KuzzleRequest request) async {
    if (_webSocket != null && _webSocket.readyState == WebSocket.OPEN) {
      _webSocket.sendString(json.encode(request));
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
    emit(ProtocolEvents.NETWORK_ON_RESPONSE_RECEIVED, [payload.data]);
  }

  void _handleError(Event event) {
    clientNetworkError(event);
  }

  void _handleDone(Event event) {
    clientDisconnected();
  }
}
