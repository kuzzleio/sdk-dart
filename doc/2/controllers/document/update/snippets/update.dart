final result = await kuzzle
  .document
  .update('nyc-open-data', 'yellow-taxi', 'some-id', {
    'name': 'Johnny'
  });