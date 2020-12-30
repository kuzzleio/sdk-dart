await kuzzle.security.createApiKey(
  'john.doe',
  'Sigfox API key');

await kuzzle.security.createApiKey(
  'john.doe',
  'LoRa 6 month API key', expiresIn: '36000');

await kuzzle.security.createApiKey(
  'john.doe',
  'LoRa permanent API key', refresh: true);

final result = await kuzzle.security.searchApiKeys('john.doe', {
  'equals': {
    'ttl': 36000
  }
}, lang: 'koncorde');

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
        "fingerprint": "4ee98cb8c614e99213e7695f822e42325d86c93cfaf39cb40e860939e784c8e6",
        "ttl": -1
      }
    },
    {
      "_id": "zXEwbG8BJASM_0-bWU-q",
      "_source": {
        "description": "LoRa 1 year API key",
        "userId": "john.doe",
        "expiresAt": 31557600000,
        "fingerprint": "4ee98cb8c614e99213e7695f822e42325d86c93cfaf39cb40e860939e784c8e6",
        "ttl": 360000
      }
    }
  ]
}
*/

print('Found ${result.total} API key.');