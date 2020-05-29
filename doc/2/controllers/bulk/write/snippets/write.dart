final result = await kuzzle
  .bulk
  .write(
    'nyc-open-data',
    'yellow-taxi',
    {
      '_kuzzle_info': {
        'author': '<kuid>',
        'createdAt': 1481816934209,
        'updatedAt': null,
        'updater': null,
      }
    });