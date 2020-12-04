---
code: true
type: page
title: updateRoleMapping
description: Updates the internal role storage mapping.
---

# updateRoleMapping

Updates the internal role storage mapping.

<br />

```dart
Future<Map<String, dynamic>> updateRoleMapping(
      Map<String, dynamic> mapping)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `mapping` | <pre>Map<String, dynamic></pre> | Role collection [mapping definition](/core/2/guides/main-concepts/data-storage) |

## Return

Returns a Map representing the new mapping.

## Usage

<<< ./snippets/update-role-mapping.dart
