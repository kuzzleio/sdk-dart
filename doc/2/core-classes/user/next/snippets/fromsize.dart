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

var res = await kuzzle.security.searchUsers(
  query: {
    'query': {
      'term': {
        'status': 'student'
      }
    }
  }, 
  from: 1, 
  size: 1);

final result = [];

while (res != null) {
  result.addAll(res.hits);
  res = await res.next();
}
