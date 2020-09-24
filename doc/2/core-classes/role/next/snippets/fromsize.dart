for (var i = 1; i <= 5; i++) {
  await kuzzle.security.createRole(
    'read-only-${i}',
    {
      'auth': {
        'actions': {
          'getCurrentUser': true,
          'getMyCredentials': true,
          'getMyRights': true,
          'logout': true
        }
      }
    }
  );
}

var res = await kuzzle.security.searchRoles(
  query:{ 'controllers': [ 'auth' ] }, 
  from: 1, 
  size: 1);

final result = [];

while (res != null) {
  result.addAll(res.hits);
  res = await res.next();
}
