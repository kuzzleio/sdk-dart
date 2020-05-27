final roomId = await kuzzle
  .realtime
  .subscribe(
    'nyc-open-data',
    'yellow-taxi',
    {},
    (notification) {
      print(notification);
  });

await kuzzle
  .realtime
  .unsubscribe(roomId);