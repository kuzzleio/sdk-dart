await kuzzle
  .realtime
  .subscribe(
    'nyc-open-data',
    'yellow-taxi',
    {
      'exists': 'name',
    },
    (notification) {
      if (notification.scope == 'out') {
        print('Document left the scope');
      } else {
        print('Document moved in the scope');
      }
    });

await kuzzle
  .document
  .create('nyc-open-data', 'yellow-taxi', 
  {
    'name': 'nina-vkote',
  }, id: 'nina-vkote');