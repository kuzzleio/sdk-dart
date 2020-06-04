final result = await kuzzle
  .document
  .get('nyc-open-data', 'yellow-taxi', 'some-id');