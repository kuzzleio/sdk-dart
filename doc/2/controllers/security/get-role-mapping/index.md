---
code: true
type: page
title: getRoleMapping
description: Gets the mapping of the internal security roles collection.
---

# getRoleMapping

Gets the mapping of the internal security roles collection.

<br />

```dart
Future<Map<String, dynamic>> getRoleMapping()
```

<br />

## Return

An object representing the internal roles mapping, using [Elasticsearch mapping format](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/mapping.html).

## Usage

<<< ./snippets/get-role-mapping.dart
