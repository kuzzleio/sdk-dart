---
code: true
type: page
title: mGetRoles
description: Gets multiple security roles
---

# mGetRoles

Gets multiple security roles.

<br />

```dart
Future<List<KuzzleRole>> mGetRoles(
    List<String> ids)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `ids` | `List<String>` | Roles identifiers |

## Resolves

A List of retrieved [`Role`](/sdk/dart/2/core-classes/role/introduction) objects.

## Usage

<<< ./snippets/m-get-roles.dart
