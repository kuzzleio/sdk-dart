import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:kuzzle/src/kuzzle/response.dart';
import 'package:pedantic/pedantic.dart';

import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import 'abstract.dart';
import 'events.dart';

class KuzzleWebSocket extends KuzzleProtocol {
  KuzzleWebSocket(
    Uri uri, {
    bool autoReconnect = true,
    Duration reconnectionDelay,
    this.pingInterval,
  })  : 
        super(uri,
            autoReconnect: autoReconnect, reconnectionDelay: reconnectionDelay);

  String _lastUrl;
  WebSocket _webSocket;
  StreamSubscription _subscription;
  Duration pingInterval;

  @override
  Future<void> connect() async {
    final url = '${uri.scheme}://${uri.host}:${uri.port}';

    await super.connect();

    if (url != _lastUrl) {
      wasConnected = false;
      _lastUrl = url;
    }

    await _subscription?.cancel();
    _subscription = null;

    await _webSocket?.close();
    _webSocket = null;

    try {
      _webSocket = await WebSocket.connect(url);
    } on IOException {
      if (wasConnected) {
        clientNetworkError(
            KuzzleError('WebSocketProtocol: Unable to connect to $url'));

        return;
      }

      rethrow;
    }

    _webSocket.pingInterval = pingInterval;

    _subscription = _webSocket.listen(_handlePayload,
        onError: _handleError, onDone: _handleDone);

    clientConnected();

    unawaited(_webSocket.done.then((error) {
      clientNetworkError(
          KuzzleError('WebSocketProtocol: connection with $url closed'));
    }));
  }

  @override
  Future<KuzzleResponse> send(KuzzleRequest request) {
    if (_webSocket != null && _webSocket.readyState == WebSocket.open) {
      _webSocket.add(json.encode(request));
    }
    return null;
  }

  @override
  void close() {
    super.close();

    removeAllListeners();
    stopRetryingToConnect = true;
    wasConnected = false;

    _subscription?.cancel();
    _subscription = null;

    _webSocket?.close();
    _webSocket = null;
  }

  void _handlePayload(dynamic payload) {
    emit(ProtocolEvents.NETWORK_ON_RESPONSE_RECEIVED, [payload]);
  }

  void _handleError(dynamic error, StackTrace stackTrace) {
    if (error is Error) {
      clientNetworkError(error);
    } else {
      clientNetworkError(KuzzleError('websocket.onError'));
    }
  }

  void _handleDone() {
    if (_webSocket.closeCode == 1000) {
      clientDisconnected();
    } else if (wasConnected) {
      clientNetworkError(KuzzleError(
          'clientNetworkError', _webSocket.closeReason, _webSocket.closeCode));
    }
  }
}
