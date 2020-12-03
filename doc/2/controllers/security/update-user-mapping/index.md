---
code: true
type: page
title: updateUserMapping
description: Updates the internal user storage mapping.
---

# updateUserMapping

Updates the internal user storage mapping.

<br />

```dart
Future<Map<String, dynamic>> updateUserMapping(
      Map<String, dynamic> mapping)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `mapping` | <pre>Map<String, dynamic></pre> | User collection [mapping definition](/core/2/guides/main-concepts/data-storage) |

## Return

Returns a Map representing the new mapping.

## Usage

<<< ./snippets/update-user-mapping.dart
