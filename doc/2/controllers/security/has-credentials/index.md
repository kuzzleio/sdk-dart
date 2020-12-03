---
code: true
type: page
title: hasCredentials
description: Checks if a user has credentials registered for the specified authentication strategy.
---

# hasCredentials

Checks if a user has credentials registered for the specified authentication strategy.

<br />

```dart
Future<bool> hasCredentials(String strategy, String id)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `strategy` | <pre>String</pre> | Strategy identifier |
| `id` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |

## Return

A boolean telling whether the user can log in using the provided authentication strategy.

## Usage

<<< ./snippets/has-credentials.dart