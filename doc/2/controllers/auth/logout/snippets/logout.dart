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

await kuzzle
  .auth
  .logout();
