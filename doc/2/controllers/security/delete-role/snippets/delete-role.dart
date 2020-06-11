final result = await kuzzle.security.deleteRole('myRole');
/*
{ found: true,
  _index: '%kuzzle',
  _type; 'roles',
  _id: 'myRole',,
  _version: 2,
  result: 'deleted',
  _shards: {  total: 2, successful: 1, failed: 0 } }
  */

print('Role successfully deleted');
