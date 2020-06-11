final result = await kuzzle.security.createOrReplaceProfile(
  'myProfile',
  [
    {
      'roleId': 'default'
    },
    {
      'roleId': 'admin',
      'restrictedTo': [
        {
          'index': 'someindex',
          'collections': [
            'collection1',
            'collection2'
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
      { roleId: 'admin', restrictedTo: [Array] } ] }
*/

