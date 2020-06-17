final result = await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    },
  );

  final exists = await kuzzle
  .auth
  .credentialsExist(
    'local'
  );

  if (exists) {
    print('Credentials exists for local strategy');
  }
