---
code: true
type: page
title: deleteUser
description: Deletes a user and all their associate credentials
---

# deleteUser

Deletes a user and all their associated credentials.

<br />

```dart
Future<Map<String, dynamic>> deleteUser(String id,
  {bool waitForRefresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `id` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the user deletion is indexed |

## Return

An object containing the `kuid` of the deleted user in its `_id` property.

## Usage

<<< ./snippets/delete-user.dart
