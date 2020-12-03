---
code: true
type: page
title: getUser
description: Gets a user
---

# getUser

Gets a user.

<br />

```dart
Future<KuzzleUser> getUser(String id)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |

## Return

The retrieved [`User`](sdk/dart/2/core-classes/user/introduction) object.

## Usage

<<< ./snippets/get-user.dart
