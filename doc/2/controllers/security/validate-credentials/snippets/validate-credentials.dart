final result = await kuzzle.security.validateCredentials(
  'local',
  'john.doe',
  {
    'username': 'jdoe',
    'password': 'password'
  }
);

/*
true
*/
