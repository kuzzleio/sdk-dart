final requestPayload = {
  'controller': 'document',
  'action': 'create',
  'index': 'nyc-open-data',
  'collection': 'yellow-taxi',
  'body': {
    'name': 'Melis'
  }
};

final result = await kuzzle
  .auth
  .checkRights(requestPayload);
