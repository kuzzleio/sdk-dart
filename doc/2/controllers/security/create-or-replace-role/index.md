---
code: true
type: page
title: createOrReplaceRole
description: Creates a new role or, if the provided role identifier already exists, replaces it.
---

# createOrReplaceRole

Creates a new role or, if the provided role identifier already exists, replaces it.

<br />

```dart
Future<KuzzleRole> createOrReplaceRole(
      String uid, Map<String, dynamic> controllers,
      {bool waitForRefresh, bool force})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `id` | <pre>String</pre> | Role identifier |
| `controllers` | <pre>Map<String, dynamic></pre> | [Role definition](/core/2/guides/main-concepts/permissions#roles) |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the created/replaced role is indexed |
| `force`   | <pre>bool</pre><br />(`null`) | If set to `true`, creates or replaces the role even if it gives access to non-existent plugins API routes. |

## Return

A [`Role`](/sdk/dart/2/core-classes/role) object representing the created/replaced role.

## Usage

<<< ./snippets/create-or-replace-role.dart
