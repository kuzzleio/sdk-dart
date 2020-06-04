---
code: true
type: page
title: UpdateSelf
description: Updates the current user object in Kuzzle.
---

# UpdateSelf

Updates the current user object in Kuzzle.

## Arguments

```dart
Future<Map<String, dynamic>> updateSelf(Map<String, dynamic> body)
```

| Argument  | Type               | Description                           |
|-----------|--------------------|---------------------------------------|
| `body` | <pre>Map<String, dynamic></pre> | Map representing the user content |

## Return

Returns a Map with the following properties:

| Property  | Type               | Description                               |
|-----------|--------------------|-------------------------------------------|
| `_id`     | <pre>String</pre>  | User's `kuid`                             |
| `_source` | <pre>Map<String, dynamic></pre> | Additional (and optional) user properties |

## Usage

<<< ./snippets/update-self.dart
