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
  .createMyCredentials(
    'other',
    {
      'username': 'foo2',
      'password': 'bar2'
    }
  );
