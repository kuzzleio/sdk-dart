import 'dart:io';

import 'package:kuzzle/kuzzle.dart';

void main() async {
  final kuzzle = Kuzzle(
    WebSocketProtocol(Uri(
    scheme: 'ws',
    host: 'kuzzle',
    port: 7512,
  )),
    offlineMode: OfflineMode.auto,
  );
  kuzzle.connect();
  [snippet-code]
  print(result.deprecations);
  kuzzle.disconnect();
  exit(0);
}
