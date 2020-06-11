final result = await kuzzle.security.updateProfile(
  'myProfile',
  [
    {
      'roleId': 'default'
    },
    {
      'roleId': 'privileged',
      'restrictedTo': [
        {
          'index': 'someindex'
        },
        {
          'index': 'anotherindex',
          'collections': [
            'coll1',
            'coll2'
          ]
        }
      ]
    }
  ]
);

/*
Profile {
  _id: 'myProfile',
  policies:
    [ { roleId: 'default' },
      { roleId: 'privileged',
        restrictedRo:
          [ { index: 'someIndex' },
            { index: 'anotherIndex', collections: [ 'coll1', 'coll2' ]  } ] } ]
*/