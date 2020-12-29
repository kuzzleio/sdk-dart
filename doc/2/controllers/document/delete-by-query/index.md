---
code: true
type: page
title: deleteByQuery
description: Delete documents matching query
---

# deleteByQuery

Deletes documents matching the provided search query.

Kuzzle uses the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

<SinceBadge version="change-me"/>

This method also supports the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) to match documents by passing the `lang` argument with the value `koncorde`.  
Koncorde filters will be translated into an Elasticsearch query.  

::: warning
Koncorde `bool` operator and `regexp` clause are not supported for search queries.
:::

An empty or null query will match all documents in the collection.


```dart
Future<List<String> deleteByQuery(
    String index,
    String collection,
    Map<String, dynamic> query, {
    bool waitForRefresh = false,
    String lang
  })
```

| Argument           | Type                                         | Description     |
| ------------------ | -------------------------------------------- | --------------- |
| `index`            | <pre>String</pre>                            | Index name      |
| `collection`       | <pre>String</pre>                            | Collection name |
| `searchQuery`      | <pre>Map<String, dynamic></pre> | Query to match  |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing |
| `lang`     | <pre>String</pre>               | Specify the query language to use. By default, it's `elasticsearch` but `koncorde` can also be used. <SinceBadge version="change-me"/> |

---

## Returns

Returns a `List<String>` containing the deleted document ids.

## Usage

With the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

<<< ./snippets/delete-by-query-es.dart

With the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) syntax.

<<< ./snippets/delete-by-query-koncorde.dart