---
code: true
type: page
title: getUserMapping
description: Gets the mapping of the internal users collection.
---

# getUserMapping

Gets the mapping of the internal users collection.

<br />

```dart
Future<Map<String, dynamic>> getUserMapping()
```

## Return

An object representing the internal users mapping, using [Elasticsearch mapping format](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/mapping.html).

## Usage

<<< ./snippets/get-user-mapping.dart
