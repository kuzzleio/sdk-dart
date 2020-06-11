final result = await kuzzle.security.createCredentials(
  'local',
  'foo',
  { 'username': 'foo', 'password': 'bar' }
);
/*
  { username: 'foo' }
*/