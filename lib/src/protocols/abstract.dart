import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

import '../kuzzle/errors.dart';
import '../kuzzle/event_emitter.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';
import 'events.dart';

final _uuid = Uuid();

enum KuzzleProtocolState {
  ready,
  connected,
  connecting,
  offline,
}

abstract class KuzzleProtocol extends KuzzleEventEmitter {
  KuzzleProtocol(
    this.uri,
  )   : _state = KuzzleProtocolState.offline,
        id = _uuid.v4();

  final Uri uri;
  final String id;

  @protected
  bool wasConnected = false;

  @protected
  bool retrying = false;

  KuzzleProtocolState _state;
  KuzzleProtocolState get state => _state;

  bool isReady() => _state == KuzzleProtocolState.connected;

  @mustCallSuper
  Future<void> connect() async {
    _state = KuzzleProtocolState.connecting;
  }

  /// Sends a payload to the connected server
  Future<KuzzleResponse> send(KuzzleRequest request);

  /// Called when the client's connection is established
  void clientConnected({
    KuzzleProtocolState state = KuzzleProtocolState.connected,
  }) {
    _state = state;
    emit(wasConnected ? ProtocolEvents.RECONNECT : ProtocolEvents.CONNECT);

    wasConnected = true;
  }

  /// Called when the client's connection is closed
  void clientDisconnected() {
    emit(ProtocolEvents.DISCONNECT);
  }

  /// Called when the client's connection is closed with an error state
  void clientNetworkError([dynamic error]) {
    _state = KuzzleProtocolState.offline;

    emit(ProtocolEvents.NETWORK_ERROR, [
      KuzzleError('Unable to connect to kuzzle server at ${uri.toString()}')
    ]);
  }

  /// Called when the client's connection is closed
  @mustCallSuper
  void close() {
    _state = KuzzleProtocolState.offline;
    clientDisconnected();
  }

  // todo: implement query options
  /// Register a response event handler for [request]
  @mustCallSuper
  Future<KuzzleResponse> query(KuzzleRequest request) {
    if (!isReady()) {
      emit(ProtocolEvents.DISCARDED, [request]);

      return Future.error(KuzzleError(
          'Unable to execute request: not connected to a Kuzzle server.'));
    }

    final completer = Completer<KuzzleResponse>();

    once(request.requestId, (response) {
      if (response.error != null) {
        emit(ProtocolEvents.QUERY_ERROR, [response.error, request]);
        return completer.completeError(response.error);
      }

      return completer.complete(response as KuzzleResponse);
    });

    try {
      final syncRes = send(request);
      // If we use a synchronous protocol the result is returned directly
      if (syncRes != null) {
        return syncRes;
      }
    } on Exception catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }
}
