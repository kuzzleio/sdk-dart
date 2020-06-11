final result = await kuzzle.security.updateCredentials(
  'local',
  'john.doe',
  {
    'username': 'jdoe',
    'password': 'newPassword'
  }
);
/*
{ username: "jdoe" }
*/