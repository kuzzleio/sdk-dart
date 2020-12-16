---
code: true
type: page
title: updateProfileMapping
description: Updates the internal profile storage mapping.
---

# updateProfileMapping

Updates the internal profile storage mapping.

<br />

```dart
Future<Map<String, dynamic>> updateProfileMapping(
      Map<String, dynamic> mapping)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `mapping` | <pre>Map<String, dynamic></pre> | Profile collection [mapping definition](/core/2/guides/main-concepts/data-storage) |

## Return

Returns an object representing the new mapping.

## Usage

<<< ./snippets/update-profile-mapping.dart