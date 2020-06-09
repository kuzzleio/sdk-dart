await kuzzle
  .realtime
  .publish("my-index", "my-collection", {
    'name': 'nina-vkote'
  });