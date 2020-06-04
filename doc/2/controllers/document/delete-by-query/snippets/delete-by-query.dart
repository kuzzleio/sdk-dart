final result = await kuzzle
  .document
  .deleteByQuery('nyc-open-data', 'yellow-taxi', {
    'query': {
      'match': {
        'capacity': 4
      }
    }
  });