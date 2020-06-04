final result = await kuzzle
  .document
  .createOrReplace('nyc-open-data', 'yellow-taxi', 'some-id', 
  {
    'firstname': 'John'
  });