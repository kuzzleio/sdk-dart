---
code: true
type: page
title: count
description: Returns the number of other connections sharing the same subscription.
---

# count

Returns the number of other connections sharing the same subscription.

## Arguments

```dart
Future<int> count(String roomId)
```

| Argument  | Type              | Description          |
|-----------|-------------------|----------------------|
| `roomId` | <pre>String</pre> | Subscription room ID |

## Return

Returns the number of active connections using the same provided subscription room.

## Usage

<<< ./snippets/count.dart
