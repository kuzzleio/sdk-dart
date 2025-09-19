import 'dart:async';

import 'package:pedantic/pedantic.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

import '../kuzzle/errors.dart';
import '../kuzzle/event_emitter.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';
import 'events.dart';

const _uuid = Uuid();

enum KuzzleProtocolState {
  connected,
  connecting,
  reconnecting,
  offline,
}

abstract class KuzzleProtocol extends KuzzleEventEmitter {
  KuzzleProtocol(
    this.uri, {
    this.autoReconnect = false,
    this.reconnectionDelay = const Duration(seconds: 1),
    this.reconnectionAttempts = 10,
  })  : protocolState = KuzzleProtocolState.offline,
        id = _uuid.v4();

  final Uri uri;
  final String id;
  bool autoReconnect;
  Duration reconnectionDelay;
  int reconnectionAttempts;

  @protected
  KuzzleProtocolState protocolState;

  @protected
  bool abortConnection = false;

  KuzzleProtocolState get state => protocolState;
  bool get connectionAborted => abortConnection;

  bool isReady() => protocolState == KuzzleProtocolState.connected;

  @nonVirtual
  Future<void> connect() async {
    if (protocolState == KuzzleProtocolState.offline) {
      abortConnection = false;
      protocolState = KuzzleProtocolState.connecting;
    }

    do {
      if (abortConnection) {
        protocolState = KuzzleProtocolState.offline;
        throw KuzzleError(
            'Unable to connect to kuzzle server at ${uri.toString()}: Connection aborted.');
      }

      try {
        await protocolConnect();
        _clientConnected();
        return;
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        emit(ProtocolEvents.NETWORK_ERROR, [e]);

        await Future.delayed(reconnectionDelay);
      }
    } while (protocolState != KuzzleProtocolState.connected);
  }

  @internal
  Future<void> protocolConnect();

  /// Sends a payload to the connected server
  @internal
  Future<void> send(KuzzleRequest request);

  /// Called when the client's connection is established
  void _clientConnected() {
    if (abortConnection) {
      protocolState = KuzzleProtocolState.connected;
      close();
      return;
    }

    final protocolStateCpy = protocolState;
    protocolState = KuzzleProtocolState.connected;
    emit(protocolStateCpy == KuzzleProtocolState.reconnecting
        ? ProtocolEvents.RECONNECT
        : ProtocolEvents.CONNECT);
  }

  /// Called when the client's connection is closed
  @internal
  void clientDisconnected() {
    if (protocolState == KuzzleProtocolState.offline) {
      return;
    }

    protocolState = KuzzleProtocolState.offline;
    emit(ProtocolEvents.DISCONNECT);
  }

  /// Called when the client's connection is closed with an error state
  @internal
  void clientNetworkError([dynamic error]) {
    if (protocolState == KuzzleProtocolState.offline) {
      return;
    }

    protocolState = KuzzleProtocolState.offline;

    unawaited(_handleAutoReconnect());
  }

  Future<void> _handleAutoReconnect() async {
    emit(ProtocolEvents.DISCONNECT);

    protocolState = KuzzleProtocolState.reconnecting;

    await connect();
  }

  /// Called when the client's connection is closed
  @mustCallSuper
  void close() {
    if (protocolState == KuzzleProtocolState.offline) {
      return;
    }

    if (protocolState == KuzzleProtocolState.connected) {
      clientDisconnected();
      return;
    }
    abortConnection = true;
  }

  // todo: implement query options
  /// Register a response event handler for [request]
  @mustCallSuper
  Future<KuzzleResponse> query(KuzzleRequest request) async {
    if (!isReady()) {
      throw KuzzleError(
          'Unable to execute request: not connected to a Kuzzle server.');
    }

    final completer = Completer<KuzzleResponse>();

    once(request.requestId!, (KuzzleResponse response) {
      if (response.error != null) {
        emit(ProtocolEvents.QUERY_ERROR, [response.error, request]);
        return completer.completeError(response.error!);
      }
      return completer.complete(response);
    });

    try {
      await send(request);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(ProtocolEvents.QUERY_ERROR, [error, request]);
      completer.completeError(error);
    }

    return completer.future;
  }
}
