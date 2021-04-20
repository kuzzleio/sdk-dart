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
    this.autoReconnect = true,
    Duration reconnectionDelay,
    this.pingInterval,
  }) : super(uri) {
    _reconnectionDelay = reconnectionDelay ?? Duration(seconds: 1);
  }

  String _lastUrl;
  WebSocket _webSocket;
  StreamSubscription _subscription;
  Duration pingInterval;
  Duration _reconnectionDelay;
  bool autoReconnect;
  bool _stopRetryingToConnect = false;
  bool _hasBeenClosed = false;

  @override
  Future<void> connect() async {
    // If a reconnection is going on 
    // and the enduser called disconnect in between
    // then don't try to connect
    if (_hasBeenClosed && retrying) {
      return;
    }
    _hasBeenClosed = false;

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

    _stopRetryingToConnect = false;

    try {
      _webSocket = await WebSocket.connect(url);
    } on IOException {
      if (wasConnected || autoReconnect) {
        clientNetworkError(
            KuzzleError('WebSocketProtocol: Unable to connect to $url'));
        _handleAutoReconnect();

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

    _hasBeenClosed = true;

    removeAllListeners();
    _stopRetryingToConnect = true;
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

  void _handleAutoReconnect() {
    if (autoReconnect && !retrying && !_stopRetryingToConnect) {
      retrying = true;

      Timer(_reconnectionDelay, () async {
        await connect().catchError(clientNetworkError);
        retrying = false;
      });
    } else {
      emit(ProtocolEvents.DISCONNECT);
    }
  }

  void _handleDone() {
    if (_webSocket.closeCode == 1000) {
      clientDisconnected();
    } else if (wasConnected || autoReconnect) {
      clientDisconnected();
      clientNetworkError(KuzzleError(
          'clientNetworkError', _webSocket.closeReason, _webSocket.closeCode));
      _handleAutoReconnect();
    }
  }
}
