final result = await kuzzle
  .document
  .mCreateOrReplace("nyc-open-data", "yellow-taxi", [
    {
      '_id': 'some-id',
      'body': {
        'Agent': 'Smith'
      }
    },
    {
      '_id': 'some-id2',
      'body': {
        'Gordon': 'Freeman'
      }
    }
  ]);