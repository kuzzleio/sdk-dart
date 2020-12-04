---
code: true
type: page
title: mDeleteRoles
description: Deletes multiple security roles.
---

# mDeleteRoles

Deletes multiple security roles.

Throws a partial error (error code 206) if one or more role deletions fail.

<br />

```dart
Future<List<dynamic>> mDeleteRoles(List<String> ids,
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `ids` | `List<String>` | Role identifiers |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the roles deletion is indexed |

## Return

A List of the deleted roles ids.

## Usage

<<< ./snippets/m-delete-roles.dart

