---
code: true
type: page
title: getConfig
description: Returns the current Kuzzle configuration.
---

# getConfig

Returns the current Kuzzle configuration.

:::warning
This route should only be accessible to administrators, as it might return sensitive information about the backend.
:::


```dart
Future<Map<String, dynamic>> getConfig()
```

## Return

Returns a `Map<String, dynamic>` containing server configuration.

## Usage

<<< ./snippets/get-config.dart
