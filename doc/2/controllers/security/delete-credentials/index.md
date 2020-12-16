---
code: true
type: page
title: deleteCredentials
description: Deletes user credentials for the specified authentication strategy
---

# deleteCredentials

Deletes user credentials for the specified authentication strategy.

<br />

```dart
Future<Map<String, dynamic>> deleteCredentials(
      String strategy, String id, {bool waitForRefresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `strategy` | <pre>String</pre> | Strategy to use |
| `id` | <pre>String</pre> | User [id](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the credentials deletion is indexed |

## Returns

An acknowledgment message.

## Usage

<<< ./snippets/delete-credentials.dart
