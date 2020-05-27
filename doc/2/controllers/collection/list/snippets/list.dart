final result = await kuzzle
  .collection
  .list('nyc-open-data', type: 'stored');