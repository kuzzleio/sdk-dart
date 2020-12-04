---
code: true
type: page
title: create
description: Creates a new collection
---

# create

Creates a new [collection](/core/2/guides/main-concepts/data-storage) in Kuzzle via the persistence engine, in the provided index.

You can also provide an optional data mapping that allows you to exploit the full capabilities of our
persistent data storage layer, [ElasticSearch](https://www.elastic.co/elastic-stack) (check here the [mapping capabilities of ElasticSearch](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/mapping.html)).

This method will only update the mapping if the collection already exists.

<br/>

---

## Arguments

```dart
Future<Map<String, dynamic>> create(
    String index,
    String collection, {
    Map<String, dynamic> mapping,
  })
```

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `mapping`          | <pre>Map<String, dynamic><String, Object></pre><br>(`{}`) | Describes the data mapping to associate to the new collection, using Elasticsearch [mapping format](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/mapping.html) |

---

### mapping

A `Map<String, dynamic>` representing the data mapping of the collection.

The mapping must have a root field `properties` that contain the mapping definition:

More information about database mappings [here](/core/2/guides/main-concepts/data-storage).

## Usage

<<< ./snippets/create.dart
