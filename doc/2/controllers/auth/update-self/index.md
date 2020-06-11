---
code: true
type: page
title: updateSelf
description: Updates the current user object in Kuzzle.
---

# UpdateSelf

Updates the current user object in Kuzzle.

## Arguments

```dart
Future<KuzzleUser> updateSelf(Map<String, dynamic> body)
```

| Argument  | Type               | Description                           |
|-----------|--------------------|---------------------------------------|
| `body` | <pre>Map<String, dynamic></pre> | Map representing the user content |

## Return

A User representing the current user logged with the SDK.

## Usage

<<< ./snippets/update-self.dart
