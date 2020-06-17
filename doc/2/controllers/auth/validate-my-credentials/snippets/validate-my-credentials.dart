await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    },
);

final result = await kuzzle
  .auth
  .validateMyCredentials(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    }
);
