final result = await kuzzle
  .bulk
  .mWrite(
    'nyc-open-data',
    'yellow-taxi',
    [
      {'_id': 'foo', 'body': {},},
    ]);