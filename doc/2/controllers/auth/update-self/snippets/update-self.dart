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

final result = await kuzzle
  .auth
  .updateSelf(
    {
      'age': 42
    }
);