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
  .deleteMyCredentials('local');
