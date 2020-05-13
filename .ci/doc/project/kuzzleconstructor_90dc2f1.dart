import 'package:kuzzle/kuzzle.dart';

void main() {
  final kuzzle = Kuzzle(
      WebSocketProtocol('kuzzle'),
      offlineMode: OfflineMode.auto,
    );
  print('Success');
}
