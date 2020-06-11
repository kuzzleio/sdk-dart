final result = await kuzzle
  .bulk
  .import(
    'nyc-open-data',
    'yellow-taxi',
    [
      { 'index': { } },
      { 'a': 'document', 'with': 'any', 'number': 'of fields' },
      { 'create': { '_id': 'uniq-id-1' } },
      { 'another': 'document' },
      { 'create': { '_id': 'uniq-id-2' } },
      { 'and': { 'another': 'one' } },
    ]);