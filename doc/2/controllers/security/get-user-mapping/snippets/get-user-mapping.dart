final result = await kuzzle.security.getUserMapping();

/*
{ mapping:
    { firstname:
        { type: 'text',
          fields: { keyword: { type: 'keyword', ignore_above: 256 } } },
      lastname:
        { type: 'text',
          fields: { keyword: { type: 'keyword', ignore_above: 256 } } },
      profileIds: { type: 'keyword' } } }
  */