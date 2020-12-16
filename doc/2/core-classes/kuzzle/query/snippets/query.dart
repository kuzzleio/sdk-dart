KuzzleResponse res = await kuzzle.query(KuzzleRequest(
  controller: 'document',
  action: 'create',
  index: 'nyc-open-data',
  collection: 'yellow-taxi',
  uid: 'my-custom-document-id',
  body: {
    'trip_distance': 4.23,
    'passenger_count': 2
  },
  waitForRefresh: true,
));