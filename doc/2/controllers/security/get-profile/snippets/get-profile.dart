final result = await kuzzle.security.getProfile('myProfile');

/*
Profile {
  _id: 'myProfile',
  policies:
    [ { roleId: 'admin',
        restrictedTo:
          [ { index: 'someIndex' },
            { index: 'anotherIndex', collections: [ 'someCollection' ] } ] },
      { roleId: 'default' } ] }
*/
