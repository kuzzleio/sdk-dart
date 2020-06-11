---
code: true
type: page
title: getStats
description: Returns statistics snapshots within a provided timestamp range.
---

# getStats

Returns statistics snapshots within a provided timestamp range.
By default, snapshots are made every 10 seconds and they are stored for 1 hour.

These statistics include:

- the number of connected users per protocol (not available for all protocols)
- the number of ongoing requests
- the number of completed requests since the last frame
- the number of failed requests since the last frame

<br/>

```dart
Future<Map<String, dynamic>> getStats(
      DateTime startTime, DateTime stopTime)
```

<br/>

| Arguments   | Type                      | Description                                                     |
| ----------- | ------------------------- | --------------------------------------------------------------- |
| `startTime` | <pre>DateTime</pre> | Begining of statistics frame set |
| `stopTime`  | <pre>DateTime</pre> | End of statistics frame set |

## Return

Returns a `Map<String, dynamic>` containing statistics snapshots within the provided range.

## Usage

<<< ./snippets/get-stats.dart
