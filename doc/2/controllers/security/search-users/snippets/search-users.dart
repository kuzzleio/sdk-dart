final result = await kuzzle.security.searchUsers(query:{
  'query': {
    'term': {
      'status': 'student'
    }
  }
});

/*
UserSearchResult {
  aggregations: undefined,
  hits:
    [ User { _kuzzle: [Kuzzle], _id: 'user2', content: [Object] },
      User { _kuzzle: [Kuzzle], _id: 'user1', content: [Object] },
      User { _kuzzle: [Kuzzle], _id: 'user3', content: [Object] } ],
  fetched: 3,
  total: 3 }
*/