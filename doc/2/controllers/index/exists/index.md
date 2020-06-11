---
code: true
type: page
title: exists
description: Check for index existence.
---

# exists

Checks if the given index exists in Kuzzle.

## Arguments

```dart
Future<bool> exists(String index)
```

| Argument | Type              | Description |
|----------|-------------------|-------------|
| `index`  | <pre>String</pre> | Index name  |

## Return

Returns a `bool` that indicates whether the index exists or not.

## Usage

<<< ./snippets/exists.dart
