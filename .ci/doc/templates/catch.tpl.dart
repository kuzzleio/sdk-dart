import 'dart:io';

import 'package:kuzzle/kuzzle.dart';

void main() async {
  final kuzzle = Kuzzle(
    WebSocketProtocol('kuzzle'),
    offlineMode: OfflineMode.auto,
  );
  try {
    kuzzle.connect();
    [snippet-code]
  } catch(e, s) {
    print(e.message);
  } finally {
  kuzzle.disconnect();
  }
  exit(0);
}