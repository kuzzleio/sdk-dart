await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    },
    expiresIn:''
  );

KuzzleUser = await kuzzle
  .auth
  .getCurrentUser();