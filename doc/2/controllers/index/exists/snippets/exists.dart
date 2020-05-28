final result = await kuzzle
  .index
  .exists('nyc-open-data');
