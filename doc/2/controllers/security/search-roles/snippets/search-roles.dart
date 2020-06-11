final result = await kuzzle.security.searchRoles(query:{
  'controllers': ['auth']
});

/*
RoleSearchResult {
  aggregations: undefined,
  hits:
    [ Role { _id: 'admin', controllers: [Object] },
      Role { _id: 'default', controllers: [Object] },
      Role { _id: 'anonymous', controllers: [Object] } ]
  fetched: 3,
  total: 3 }
*/