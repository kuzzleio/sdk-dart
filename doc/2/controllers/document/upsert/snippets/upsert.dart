final result = await kuzzle
  .document
  .upsert('nyc-open-data', 'yellow-taxi', 'some-id', {
      'changes': { 'category': 'suv' },
    },
  );