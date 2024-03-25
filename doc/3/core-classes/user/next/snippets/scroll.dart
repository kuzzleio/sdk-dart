for (var i = 1; i <= 5; i++) {
  await kuzzle.security.createUser('jdoe-${i}', {
    'content': {
      'profileIds': [ 'default' ],
      'status': 'student'
    },
    'credentials': {
      'local': {
        'username': 'jdoe-${i}',
        'password': 'password'
      }
    }
  });
}

SearchResult? res = await kuzzle.security.searchUsers(
  query: {
    'query': {
      'term': {
        'status': 'student'
      }
    }
  }, 
  scroll: '10s', 
  size: 1);

final result = [];

while (res != null) {
  result.addAll(res.hits as Iterable<dynamic>);
  res = await res.next();
}
