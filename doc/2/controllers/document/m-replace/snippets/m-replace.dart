final result = await kuzzle
  .document
  .mReplace('nyc-open-data', 'yellow-taxi', [
    {
      '_id': 'some-id',
      'body': {
        'name': 'Smith'
      }
    }, 
    {
      '_id': 'some-id2',
      'body': {
        'name': 'Freeman'
      }
    }
  ]);