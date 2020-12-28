final result = await kuzzle
  .document
  .updateByQuery('nyc-open-data', 'yellow-taxi', searchQuery: {
    'match': {
      'capacity': 4,
    },
  }, 
  changes: {
    'capacity': 42,
  });