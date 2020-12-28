final result = await kuzzle
  .document
  .deleteByQuery('nyc-open-data', 'yellow-taxi', {
    'equals': {
        'capacity': 4
      }
    },
      lang: 'koncorde'
  );