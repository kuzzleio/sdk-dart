final result = await kuzzle.security.replaceUser('john.doe', {
  'profileIds': [ 'default' ],
  'firstName': 'John',
  'lastName': 'Doe'
});

/*
User {
  _id: 'john.doe',
  content:
    { profileIds: [ 'default' ],
      firstName: 'John',
      lastName: 'Doe',
      _kuzzle_info:
        { author: -1,
          createdAt: 1561461975256,
          updatedAt: null,
          updater: null } } }
  */