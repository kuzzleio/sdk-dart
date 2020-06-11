final result = await kuzzle.security.updateRoleMapping({
  'properties': {
    'description': { 'type': 'text' }
  }
});
/*
{
  properties: {
    description: { type: 'text' }
  }
}
*/