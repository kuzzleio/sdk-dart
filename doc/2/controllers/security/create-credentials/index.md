---
code: true
type: page
title: createCredentials
description: Creates authentication credentials for a user
---

# createCredentials

Creates authentication credentials for a user.

<br />

```dart
Future<Map<String, dynamic>> createCredentials(
      String strategy,
      String uid,
      Map<String, dynamic> credentials,
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `strategy` | <pre>string</pre> | Strategy to use |
| `kuid` | <pre>string</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `credentials` | <pre>object</pre> | New credentials |
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

An `Map<String, dynamic>` representing the new credentials.  
The content depends on the authentication strategy.

## Usage

<<< ./snippets/create-credentials.dart
