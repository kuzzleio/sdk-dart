final result = await kuzzle.security.createApiKey(
  'john.doe',
  'Sigfox API key');

  /*
  {
    _id: '-fQRa28BsidO6V_wmOcL',
    _source: {
      description: 'Sigfox API key',
      userId: 'john.doe',
      expiresAt: -1,
      ttl: -1,
      token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiJqb2huLmRvZSIsImlhdCI6MTU3ODA0OTMxMn0.XO_keW6EtsCGmPzxVJCChU9VREakEECDGg-N5lhCfF8'
    }
  }
  */