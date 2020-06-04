---
code: true
type: page
title: getLastStats
description: Returns the most recent statistics snapshot.
---

# getLastStats

Returns the most recent statistics snapshot.

By default, snapshots are made every 10 seconds and they are stored for 1 hour.

These statistics include:

- the number of connected users per protocol (not available for all protocols)
- the number of ongoing requests
- the number of completed requests since the last frame
- the number of failed requests since the last frame


```dart
Future<Map<String, dynamic>> getLastStats()
```

## Return

Returns an `Map<String, dynamic>` containing the most recent statistics snapshot.

## Usage

<<< ./snippets/get-last-stats.dart
