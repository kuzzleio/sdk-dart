import 'dart:io';

import 'package:kuzzle/kuzzle.dart';
import 'package:kuzzle/src/kuzzle/profile.dart';
import 'package:kuzzle/src/kuzzle/role.dart';
import 'package:kuzzle/src/kuzzle/user.dart';

void main() async {
  final kuzzle = Kuzzle(
    WebSocketProtocol('kuzzle'),
    offlineMode: OfflineMode.auto,
  );
  kuzzle.connect();
  [snippet-code]
  print('Success');
  kuzzle.disconnect();
  exit(0);
}
