final result = await kuzzle.security.updateUser(
  'john.doe',
  {
    'profileIds': ['default'],
    'firstName': 'John',
    'lastName': 'Doe'
  }
);

/*
User {
  _id: 'john.doe',
  content:,
    { profileIds: [ 'default' ],
      fullName: 'John Doe',
      _kuzzle_info:
        { author: '-1',
          createdAt: 1561379086534,
          updatedAt: null,
          updater: null } } }
*/
