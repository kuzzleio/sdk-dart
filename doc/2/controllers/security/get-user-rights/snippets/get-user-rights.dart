final result = await kuzzle.security.getUserRights('john.doe');

/*
[ { controller: '*',
  action: '*',
  index: '*',
  collection: '*',
  value: 'allowed' } ]
*/
