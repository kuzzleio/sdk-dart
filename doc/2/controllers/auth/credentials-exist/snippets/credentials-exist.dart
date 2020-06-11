final result = await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    },
    expiresIn: ''
  );

  final exists = await kuzzle
  .auth
  .credentialsExist(
    'local'
  );

  if (exists) {
    print('Credentials exists for local strategy');
  }
