await kuzzle
  .auth
  .login(
    'local',
    {
      'username': 'foo',
      'password': 'bar'
    },
);

await kuzzle
  .auth
  .updateSelf(
    {
      'age': 42
    }
);
