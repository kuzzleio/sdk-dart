final result = await kuzzle.security.mDeleteProfiles([
    'profile1',
    'profile2',
    'profile3',
    'profile4',
    'profile5'
]);

  /*
  [ 'profile1', 'profile2', 'profile3', 'profile4', 'profile5' ]
   */