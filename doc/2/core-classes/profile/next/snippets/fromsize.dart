for (var i = 1; i <= 5; i++) {
  await kuzzle.security.createProfile(
    'myProfile-${i}',
    [
      {
        'roleId': 'default'
      }
    ]
  );
}

var res = await kuzzle.security.searchProfiles(
  query:{ 'roles': [ 'default' ] }, 
  from: 1, 
  size: 1);

final result = [];

while (res != null) {
  result.addAll(res.hits);
  res = await res.next();
}
