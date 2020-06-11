final result = await kuzzle.security.updateProfileMapping({
  'properties': {
    'description': { 'type': 'text' }
  }
});

/*
  {
    properties: {
      description: { type: 'text' }
    }
  }
*/