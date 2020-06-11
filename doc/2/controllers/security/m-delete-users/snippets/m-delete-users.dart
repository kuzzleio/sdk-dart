final result = await kuzzle.security.mDeleteUsers([
  'user1',
  'user2',
  'user3'
]);

/*
[ 'user1', 'user2', 'user3' ]
  */
