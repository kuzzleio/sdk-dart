final result = await kuzzle.security.mGetUsers([
  'user1',
  'user2',
  'user3'
]);

/*
[ User {
    _id: 'user1',
    profileIds: ['profile1'],
  User {
    _id: 'user2',
    profileIds: ['profile2'],
  User {
    _id: 'user3',
    profileIds: ['profile3'] ]
  */