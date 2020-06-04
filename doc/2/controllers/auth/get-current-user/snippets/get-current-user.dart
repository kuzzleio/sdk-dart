await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    },
    expiresIn: ''
  );

KuzzleUser user = await kuzzle
  .auth
  .getCurrentUser();
