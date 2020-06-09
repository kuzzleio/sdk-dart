final roomId = await kuzzle
  .realtime
  .subscribe(
    'nyc-open-data',
    'yellow-taxi',
    {
      'exists': 'name',
    },
    (notification) {
      print(notification);
    });

final result = await kuzzle
  .realtime
  .count(roomId);