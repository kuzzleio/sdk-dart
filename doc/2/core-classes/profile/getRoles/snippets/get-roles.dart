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

List<KuzzleProfile> profiles = await user.getProfiles();
List<KuzzleRole> roles = await profiles[0].getRoles();
