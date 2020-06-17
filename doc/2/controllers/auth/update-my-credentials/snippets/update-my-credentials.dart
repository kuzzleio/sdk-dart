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
  .updateMyCredentials(
    'local',
    {
      'username': 'foo2',
      'password': 'bar2'
    }
);
