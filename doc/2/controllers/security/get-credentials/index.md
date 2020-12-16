---
code: true
type: page
title: getCredentials
description: Gets a user's credential information for the specified authentication strategy.
---

# getCredentials

Gets a user's credential information for the specified authentication strategy.

<br />

```dart
Future<Map<String, dynamic>> getCredentials(
      String strategy, String id)
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `strategy` | <pre>String</pre> | Strategy identifier |
| `id` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |

## Return

A Map containing the credential information (depends on the authentication strategy).

## Usage

<<< ./snippets/get-credentials.dart
