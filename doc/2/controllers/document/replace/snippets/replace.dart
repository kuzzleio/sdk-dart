final result = await kuzzle
  .document
  .replace('nyc-open-data', 'yellow-taxi', 'some-id', {
    'firstname': 'John',
  });