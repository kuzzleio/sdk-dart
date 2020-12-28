final result = await kuzzle
  .document
  .search('nyc-open-data', 'yellow-taxi', query: {
    'query': {
      'match': {
        'category': 'suv'
      }
    }
  });
