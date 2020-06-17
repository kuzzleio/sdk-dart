await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    },
  );

KuzzleUser user = await kuzzle
  .auth
  .getCurrentUser();
