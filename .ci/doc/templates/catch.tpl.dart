import 'dart:io';

import 'package:kuzzle/kuzzle.dart';

void main() async {
  KuzzleProtocol protocol;
  if (Platform.environment['SNIPPET_PROTOCOL'] == 'http') {
    protocol = HttpProtocol(
      Uri(
        scheme: 'http',
        host: 'kuzzle',
        port: 7512,
      )
    );
  } else {
    protocol = WebSocketProtocol(
      Uri(
        scheme: 'ws',
        host: 'kuzzle',
        port: 7512,
      )
    );
  }

  final kuzzle = Kuzzle(
    protocol,
    offlineMode: OfflineMode.auto,
  );
  
  try {
    await kuzzle.connect();
    [snippet-code]
  } catch(e, s) {
    print(e);
  } finally {
  kuzzle.disconnect();
  }
  exit(0);
}