import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:kuzzle/src/kuzzle/events.dart';
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
    // If a reconnection is going on
    // and the enduser called disconnect in between
    // then don't try to connect
    if (connectionAborted) {
      return;
    }

    final url = '${uri.scheme}://${uri.host}:${uri.port}';

    await _subscription?.cancel();
    _subscription = null;

    await _webSocket?.close();
    _webSocket = null;

    _webSocket = await WebSocket.connect(url);

    _webSocket!.pingInterval = pingInterval;

    _subscription = _webSocket!
        .listen(_handlePayload, onError: _handleError, onDone: _handleDone);
  }

  @override
  Future<void> send(KuzzleRequest request) async {
    if (_webSocket != null && _webSocket!.readyState == WebSocket.open) {
      _webSocket!.add(json.encode(request));
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

  void _handlePayload(dynamic payload) {
    try {
      final _json = json.decode(payload as String) as Map<String, dynamic>;
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

  void _handleError(dynamic error, StackTrace stackTrace) {
    if (error is Error) {
      clientNetworkError(error);
    } else {
      clientNetworkError(KuzzleError('websocket.onError'));
    }
  }

  void _handleDone() {
    if (_webSocket!.closeCode == 1000) {
      clientDisconnected();
    } else if (state == KuzzleProtocolState.connected) {
      clientNetworkError(KuzzleError('clientNetworkError',
          _webSocket!.closeReason, _webSocket!.closeCode));
    }
  }
}
