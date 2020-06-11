final result = await kuzzle.security.getProfileRights('myProfile');
/*
[ { controller: 'auth',
    action: 'login',
    index: '*',
    collection: '*',
    value: 'allowed'
  },
  { controller: 'document',
    action: 'get',
    index: 'someIndex',
    collection: '*',
    value: 'allowed'
  } [..]
]
*/