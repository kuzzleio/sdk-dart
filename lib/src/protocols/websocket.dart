import 'package:kuzzle/src/protocols/websocket_io.dart'
    if (dart.library.html) 'package:kuzzle/src/protocols/websocket_browser.dart';

class WebSocketProtocol extends KuzzleWebSocket {
  WebSocketProtocol(
    Uri uri, {
    bool autoReconnect = true,
    Duration reconnectionDelay,
    Duration pingInterval,
  }) : super(
          uri,
          autoReconnect: autoReconnect,
          reconnectionDelay: reconnectionDelay,
          pingInterval: pingInterval,
        );
}
