---
code: true
type: page
title: deleteRole
description: Deletes a security role
---

# deleteRole

Deletes a security role.

<br />

```dart
 Future<Map<String, dynamic>> deleteRole(String id,
  {bool waitForRefresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `id` | <pre>String</pre> | Role identifier |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the role deletion is indexed |

## Return

An object containing the `kuid` of the deleted role in its `_id` property.

## Usage

<<< ./snippets/delete-role.dart
