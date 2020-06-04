final result = await kuzzle
  .document
  .count('nyc-open-data', 'yellow-taxi', query: {
    'query': {
      'match': {
        'Hello': 'Clarisse',
      },
    },
  });