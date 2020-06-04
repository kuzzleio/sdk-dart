final result = await kuzzle
  .document
  .exists('nyc-open-data', 'yellow-taxi', 'some-id');