final result = await kuzzle
  .index
  .mDelete(['nyc-open-data']);
