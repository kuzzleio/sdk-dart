---
code: true
type: page
title: mDelete
description: Deletes multiple indexes.
---

# mDelete

Deletes multiple indexes.

## Arguments

```dart
Future<List<String>> mDelete(List<String> indexes)
```

| Argument  | Type              | Description           |
|-----------|-------------------|-----------------------|
| `indexes` | `List<String>` | List of indexes names |

## Return

Returns an `List<String>` containing the list of indexes names deleted.

## Usage

<<< ./snippets/mDelete.dart
