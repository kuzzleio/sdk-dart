await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'user',
      'password': 'bar'
    },
);

final result = await kuzzle
  .auth
  .updateMyCredentials(
    'local',
    {
      'username': 'user2',
      'password': 'bar2'
    }
);
