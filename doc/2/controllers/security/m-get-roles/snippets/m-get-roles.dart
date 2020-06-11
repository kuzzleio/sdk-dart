final result = await kuzzle.security.mGetRoles([
  'role1',
  'role2',
  'role3'
]);

/*
[ Role {
    _id: 'role1',
    controllers: { '*': [Object] } },
  Role {
    _id: 'role2',
    controllers: { '*': [Object] } },
  Role {
    _id: 'role3',
    controllers: { '*': [Object] } } ]
*/