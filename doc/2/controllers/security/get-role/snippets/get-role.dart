final result = await kuzzle.security.getRole('myRole');

/*
Role {
  _id: 'myRole',
  controllers:
    { auth:
      { actions: { login: true, getMyRights: true, updateSelf: true } },
      document: { actions: { get: true, search: true } } } }
*/