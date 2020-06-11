---
code: true
type: page
title: getProfileMapping
description: Gets the mapping of the internal security profiles collection
---

# getProfileMapping

Gets the mapping of the internal security profiles collection.

<br />

```dart
Future<Map<String, dynamic>> getProfileMapping()
```

<br />

## Return

An object representing the internal profiles mapping, using [Elasticsearch mapping format](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/mapping.html).

## Usage

<<< ./snippets/get-profile-mapping.dart
