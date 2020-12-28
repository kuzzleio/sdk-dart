final result = await kuzzle
  .document
  .deleteByQuery('nyc-open-data', 'yellow-taxi', {
    'query': {
      'equals': {
          'capacity': 4
        }
      }
    },
      lang: 'koncorde'
  );