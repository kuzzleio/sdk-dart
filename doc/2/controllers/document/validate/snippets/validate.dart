final result = await kuzzle
  .document
  .validate('nyc-open-data', 'yellow-taxi', {
    'key': 'value',
  });
