---
code: true
type: page
title: createApiKey
description: Creates a new API key for a user
---

# createApiKey

<SinceBadge version="7.1.0" />

<SinceBadge version="Kuzzle 2.1.0" />

Creates a new API key for a user.

<br />

```dart
Future<Map<String, dynamic>> createApiKey(
      String userId, String description,
      {String expiresIn, bool refresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `userId` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `description` | <pre>String</pre> | API key description |
| `expiresIn` | <pre>String</pre><br />(`-1`) | Expiration duration |
| `refresh` | <pre>bool</pre><br />(`false`) | If set to `wait_for`, Kuzzle will not respond until the API key is indexed |

**Notes**:
- `expiresIn`:
  - if a raw number is provided (not enclosed between quotes), then the expiration delay is in milliseconds. Example: `86400000`
  - if this value is a string, then its content is parsed by the [ms](https://www.npmjs.com/package/ms) library. Examples: `"6d"`, `"10h"`
  - if `-1` is provided, the token will never expire

## Return

An object containing the newly created API key:

| Name      | Type              | Description      |
| --------- | ----------------- | ---------------- |
| `_id`      | <pre>String</pre> | ID of the newly created API key |
| `_source`  | <pre>Map<String, dynamic></pre> | API key content |

The API key content has the following properties:

| Name      | Type              | Description      |
| --------- | ----------------- | ---------------- |
| `userId`      | <pre>String</pre> | User kuid |
| `expiresAt`  | <pre>int</pre> | Expiration date in UNIX micro-timestamp format (`-1` if the token never expires) |
| `ttl`  | <pre>int</pre> | Original TTL |
| `description`  | <pre>String</pre> | API key description |
| `token`  | <pre>String</pre> | Authentication token associated with this API key |

::: warning
The authentication token `token` will never be returned by Kuzzle again. If you lose it, you'll have to delete the API key and recreate a new one.
:::

## Usage

<<< ./snippets/create-api-key.dart
