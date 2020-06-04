await kuzzle
  .document
  .delete('nyc-open-data', 'yellow-taxi', 'some-id');
