final result = await kuzzle.security.searchProfiles(query:{
  'roles': [ 'default' ]
});

/*
ProfileSearchResult { aggregations: undefined,
  hits:
    [ Profile { _id: 'profile1', policies: [Array] },
      Profile { _id: 'profile2', policies: [Array] },
      Profile { _id: 'profile3', policies: [Array] },
      Profile { _id: 'default', policies: [Array] } ],
  fetched: 4,
  total: 4 }
*/