---
code: true
type: page
title: mDeleteUsers
description: Deletes multiple users
---

# mDeleteUsers

Deletes multiple users.

Throws a partial error (error code 206) if one or more user deletions fail.

<br />

```dart
 Future<List<dynamic>> mDeleteUsers(List<String> ids,
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `ids` | <pre>List<String></pre> | Array of user [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |

| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the users deletion is indexed |

## Return

A List of the deleted user ids.

## Usage

<<< ./snippets/m-delete-users.dart
