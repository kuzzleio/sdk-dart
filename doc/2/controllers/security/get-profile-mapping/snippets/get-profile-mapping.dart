final result = await kuzzle.security.getProfileMapping();

/*
{ mapping:
  { policies:
    { properties:
      { restrictedTo:
        { properties:
          { collections:
            { type: 'text',
              fields: { keyword: { type: 'keyword', ignore_above: 256 } } },
            index:
            { type: 'text',
              fields: { keyword: { type: 'keyword', ignore_above: 256 } } } } },
        roleId: { type: 'keyword' } } } } }
  */