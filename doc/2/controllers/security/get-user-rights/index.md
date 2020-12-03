---
code: true
type: page
title: getUserRights
description: Gets the detailed rights granted to a user
---

# getUserRights

Gets the detailed rights granted to a user.

<br />

```dart
Future<List<dynamic>> getUserRights(String id)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | User [id](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |

## Return

A List of objects. Each object is a security right granted or denied to the user:

- `controller`: impacted controller
- `action`: impacted controller action
- `index`: index name
- `collection`: collection name
- `value`: tell if access if `allowed` or `denied`. If closures have been configured on the detailed scope, the value is `conditional`.


## Usage

<<< ./snippets/get-user-rights.dart
