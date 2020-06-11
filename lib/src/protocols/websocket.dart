import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:pedantic/pedantic.dart';

import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import 'abstract.dart';
import 'events.dart';

class WebSocketProtocol extends KuzzleProtocol {
  WebSocketProtocol(
    Uri uri, {
    bool autoReconnect = true,
    Duration reconnectionDelay,
    Duration pingInterval,
  })  : _pingInterval = pingInterval,
        super(
          uri,
          autoReconnect: autoReconnect,
          reconnectionDelay: reconnectionDelay
        );

  String _lastUrl;
  WebSocket _webSocket;
  StreamSubscription _subscription;
  Duration _pingInterval;
  Duration get pingInterval => _pingInterval;
  set pingInterval(Duration value) {
    _pingInterval = value;
    _webSocket?.pingInterval = value;
  }

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

    _webSocket.pingInterval = _pingInterval;

    _subscription = _webSocket.listen(_handlePayload,
        onError: _handleError, onDone: _handleDone);

    clientConnected();

    unawaited(_webSocket.done.then((error) {
      // print('WebSocketProtocol done');
      // print(error.runtimeType);
      clientNetworkError(
          KuzzleError('WebSocketProtocol: connection with $url closed'));
    }));
  }

  @override
  void send(KuzzleRequest request) {
    if (_webSocket != null && _webSocket.readyState == WebSocket.open) {
      _webSocket.add(json.encode(request));
    }
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
      clientNetworkError(
          KuzzleError('clientNetworkError', 
          _webSocket.closeReason, 
          _webSocket.closeCode)
      );
    }
  }
}
