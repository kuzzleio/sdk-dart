final result = await kuzzle
  .document
  .mGet('nyc-open-data', 'yellow-taxi', [
    'some-id',
    'some-id2'
  ]);