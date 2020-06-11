---
code: true
type: page
title: info
description: Returns information about Kuzzle server.
---

# info

Returns information about Kuzzle: available API (base + extended), plugins, external services (Redis, Elasticsearch, ...), servers, etc.

<br/>

```dart
Future<Map<String, dynamic>> info()
```

## Return

Returns a `Map<String, dynamic>` containing server information.

## Usage

<<< ./snippets/info.dart
