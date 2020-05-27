import 'dart:async';

import 'package:kuzzle/kuzzle.dart';

Future<void> main() async {
  final kuzzle = Kuzzle(
    WebSocketProtocol('127.0.0.1'),
    offlineMode: OfflineMode.auto,
  );

  final filters = <String, dynamic>{};

  await kuzzle.connect();

  final roomId =
      await kuzzle.realtime.subscribe('index', 'collection', filters, listener);
  print('subscribing to room $roomId');

  Timer.periodic(Duration(seconds: 2), (_) {
    print('publishing realtime message');
    kuzzle.realtime.publish('index', 'collection', <String, dynamic>{
      'message': 'hello world',
      'sendedAt': DateTime.now().millisecondsSinceEpoch,
    });
  });

  // await kuzzle.realtime.unsubscribe(roomId);

  // Timer(Duration(seconds: 60), () {
  //   print('unsubscribing from room $roomId');
  //   kuzzle.realtime.unsubscribe(roomId);
  // });
}

void listener(KuzzleResponse response) {
  print('received realtime message');
  print(response.result);
}
