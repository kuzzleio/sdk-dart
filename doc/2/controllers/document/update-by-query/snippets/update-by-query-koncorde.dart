final result = await kuzzle
  .document
  .updateByQuery('nyc-open-data', 'yellow-taxi', searchQuery: {
    'equals': {
      'capacity': 4,
    },
  }, 
  changes: {
    'capacity': 42,
  }, lang: 'koncorde');