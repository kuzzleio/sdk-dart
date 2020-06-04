
final result = await kuzzle
  .document
  .create(
    'nyc-open-data',
    'yellow-taxi',
    {
      'firstname': 'John'
    },
  );