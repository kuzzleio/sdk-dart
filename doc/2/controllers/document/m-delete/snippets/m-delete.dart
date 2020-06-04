final result = await kuzzle
  .document
  .mDelete('nyc-open-data', 'yellow-taxi', [
    'some-id',
    'some-id2'
  ]);