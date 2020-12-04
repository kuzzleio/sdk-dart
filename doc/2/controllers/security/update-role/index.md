---
code: true
type: page
title: updateRole
description: Updates a security role definition
---

# updateRole

Updates a security role definition.

**Note**: partial updates are not supported for roles, this API route will replace the entire role content with the provided one.

<br />

```dart
Future<KuzzleRole> updateRole(String id, Map<String, dynamic> controllers,
      {bool waitForRefresh, bool force})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | Role identifier |
| `body` | <pre>Map<String, dynamic></pre> | Role definition content |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the updated role is indexed |
| `force`   | <pre>bool</pre><br />(`null`) | If set to `true`, updates the role even if it gives access to non-existent plugins API routes |

### body

| Property | Type | Description |
| --- | --- | --- |
| `controllers` | <pre>Map<String, dynamic>t</pre> | [Role definition](/core/2/guides/main-concepts/permissions#roles) |

## Return

A [`Role`](/sdk/dart/2/core-classes/role) object representing the updated role.

## Usage

<<< ./snippets/update-role.dart
