---
code: true
type: page
title: createRole
description: Creates a new role
---

# createRole

Creates a new role.

<br />

```dart
Future<KuzzleRole> createRole(String id, Map<String, dynamic> controllers,
  {bool waitForRefresh, bool force})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | Role identifier |
| `controllers` | <pre>Map<String, dynamic></pre> | [Role definition](/core/2/guides/main-concepts/permissions#roles) |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `wait_for`, Kuzzle will not respond until the created role is indexed |
| `force`   | <pre>bool</pre><br />(`null`) | If set to `true`, creates the role even if it gives access to non-existent plugins API routes |

## Return

A [`Role`](/sdk/dart/2/core-classes/role) object representing the created/replaced role.

## Usage

<<< ./snippets/create-role.dart
