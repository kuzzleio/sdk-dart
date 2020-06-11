final result = await kuzzle.security.deleteProfile('myProfile');
print('Profile successfully deleted');
/*
{ found: true,
  _index: '%kuzzle',
  _type: 'profiles',
  _id: 'myProfile',
  _version: 29,
  result: 'deleted',
  _shards: { total: 2, successful: 1, failed: 0 } }
  */