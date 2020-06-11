final result = await kuzzle.security.createUser('jdoe', {
  'content': {
    'profileIds': [ 'default' ]
  },
  'credentials': {
    'local': {
      'username': 'jdoe',
      'password': 'password'
    }
  }
});

/*
User {
  _id: 'john.doe',
  content:,
    { profileIds: [ 'default' ],
      firstName: 'John',
      lastName: 'Doe',
      fullName: 'John Doe',
      _kuzzle_info:
        { author: '-1',
          createdAt: 1561379086534,
          updatedAt: null,
          updater: null } } }
  */