final result = await kuzzle.security.updateUserMapping({
  'properties': {
    'firstName': { 'type': 'text' },
    'lastName': { 'type': 'text' },
    'birthDate': {
      'type': 'date',
      'format': 'yyyy-mm-dd'
    }
  }
});

/*
  {
    properties: {
      firstName: { type: 'text' },
      lastName: { type: 'text' },
      birthDate: {
        type: 'date',
        format: 'yyyy-mm-dd'
      }
    }
  }
*/
