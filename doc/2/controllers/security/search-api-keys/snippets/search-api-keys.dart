await kuzzle.security.createApiKey(
  'john.doe',
  'Sigfox API key');

await kuzzle.security.createApiKey(
  'john.doe',
  'LoRa 6 month API key', expiresIn: '6m');

await kuzzle.security.createApiKey(
  'john.doe',
  'LoRa permanent API key', refresh: true);

final result = await kuzzle.security.searchApiKeys('john.doe', {
  'match': {
    'description': 'LoRa'
  }
});

print(result);

/*
{
  "total": 2,
  "hits": [
    {
      "_id": "znEwbG8BJASM_0-bWU-q",
      "_source": {
        "description": "LoRa permanent API key",
        "userId": "john.doe",
        "expiresAt": -1,
        "ttl": -1
      }
    },
    {
      "_id": "zXEwbG8BJASM_0-bWU-q",
      "_source": {
        "description": "LoRa 1 year API key",
        "userId": "john.doe",
        "expiresAt": 31557600000,
        "ttl": 360000
      }
    }
  ]
}
*/

print('Found ${result.total} API keys matching "LoRa"');