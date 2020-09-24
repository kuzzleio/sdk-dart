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
  scroll: '10s', 
  size: 1);

final result = [];

while (res != null) {
  result.addAll(res.hits);
  res = await res.next();
}
