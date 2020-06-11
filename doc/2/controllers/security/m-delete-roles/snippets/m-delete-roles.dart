final result = await kuzzle.security.mDeleteRoles([
    'role1',
    'role2',
    'role3',
    'role4',
    'role5'
  ]);

/*
[ 'role1', 'role2', 'role3', 'role4', 'role5' ]
  */