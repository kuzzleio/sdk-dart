---
code: true
type: page
title: count
description: Counts documents in a collection.
---

# count

Counts documents in a collection.

A query can be provided to alter the count result, otherwise returns the total number of documents in the collection.

Kuzzle uses the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

---

## Arguments

```dart
Future<int> count(
    String index,
    String collection,
    {
    Map<String, dynamic> query
})
```

---

| Argument           | Type                                         | Description     |
| ------------------ | -------------------------------------------- | --------------- |
| `index`            | <pre>String</pre>                            | Index name      |
| `collection`       | <pre>String</pre>                            | Collection name |
| `query`      | <pre>Map<String, dynamic></pre><br>(`{}`) | Query to match  |

---

## Return

Returns an int.

## Usage

<<< ./snippets/count.dart
