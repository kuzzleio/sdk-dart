---
code: true
type: page
title: deleteByQuery
description: Delete documents matching query
---

# deleteByQuery

Deletes documents matching the provided search query.

Kuzzle uses the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

An empty or null query will match all documents in the collection.


```dart
Future<List<String> deleteByQuery(
    String index,
    String collection,
    Map<String, dynamic> query, {
    bool waitForRefresh = false,
  })
```

| Argument           | Type                                         | Description     |
| ------------------ | -------------------------------------------- | --------------- |
| `index`            | <pre>String</pre>                            | Index name      |
| `collection`       | <pre>String</pre>                            | Collection name |
| `searchQuery`      | <pre>Map<String, dynamic></pre> | Query to match  |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing|

---

## Returns

Returns a `List<String>` containing the deleted document ids.

## Usage

<<< ./snippets/delete-by-query.dart
