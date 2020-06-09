await kuzzle
  .realtime
  .subscribe(
    'nyc-open-data',
    'yellow-taxi',
    {
      'range': {
        'age': {
          'lte': 20
        }
      }
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
    'age': 19,
  }, id: 'nina-vkote');

await kuzzle
  .document
  .update('nyc-open-data', 'yellow-taxi', 'nina-vkote',
  {
    'age': 42,
  });
