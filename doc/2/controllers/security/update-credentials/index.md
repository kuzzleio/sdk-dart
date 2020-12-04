---
code: true
type: page
title: updateCredentials
description: Updates a user credentials for the specified authentication strategy.
---

# updateCredentials

Updates a user credentials for the specified authentication strategy.

<br />

```dart
 Future<Map<String, dynamic>> updateCredentials(
      String strategy, String id, Map<String, dynamic> credentials,
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `strategy` | <pre>String</pre> | Strategy to use |
| `id` | <pre>String</pre> | User [id](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `credentials` | <pre>Map<String, dynamic></pre> | New credentials |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the credentials are indexed |

### credentials

The credentials to send. The expected properties depend on the target authentication strategy.

Example for the `local` strategy:

```dart
{
  'username': 'foo',
  'password': 'bar'
}
```

## Return

A `Map<String, dynamic>` representing the new credentials.  
The content depends on the authentication strategy.

## Usage

<<< ./snippets/update-credentials.dart
