final jwt = await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    }
  );

final token = await kuzzle
  .auth
  .checkToken(jwt);
