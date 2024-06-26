---
code: true
type: page
title: updateByQuery
description: Updates documents matching query
---

# updateByQuery

Updates documents matching the provided search query.

Kuzzle uses the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

<SinceBadge version="change-me"/>

This method also supports the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) to match documents by passing the `lang` argument with the value `koncorde`.  
Koncorde filters will be translated into an Elasticsearch query.  

::: warning
Koncorde `bool` operator and `regexp` clause are not supported for search queries.
:::

An empty or null query will match all documents in the collection.

<br/>

```dart
Future<Map<String, dynamic>> updateByQuery(
    String index,
    String collection,
    {
    required Map<String, dynamic> searchQuery,
    required Map<String, dynamic> changes,
    bool waitForRefresh = false,
    bool source = false,
    String lang?
  })
```

| Argument           | Type                                         | Description     |
| ------------------ | -------------------------------------------- | --------------- |
| `index`            | <pre>String</pre>                            | Index name      |
| `collection`       | <pre>String</pre>                            | Collection name |
| `searchQuery`      | <pre>Map<String, dynamic></pre> | Query to match  |
| `changes`          | <pre>Map<String, dynamic></pre> | Partial changes to apply to the documents |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                           | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing|
| `source`           | <pre>bool</pre><br>(`false`)                           | If true, returns the updated document inside the response |
| `lang`     | <pre>String?</pre>               | Specify the query language to use. By default, it's `elasticsearch` but `koncorde` can also be used. <SinceBadge version="change-me"/> |

---

## Returns

A `Map<String, dynamic>` which has a `successes` and `errors`:
Each updated document is an object of the `successes` array with the following properties:

| Property     | Type                                         | Description                      |
|------------- |--------------------------------------------- |--------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Updated document (if `source` option set to true)  |
| `_id`        | <pre>String</pre>                            | ID of the udated document                   |
| `_version`   | <pre>int</pre>                           | Version of the document in the persistent data storage |
| `status`     | <pre>int</pre>                           | HTTP status code |

Each errored document is an object of the `errors` array with the following properties:

| Property     | Type                                         | Description                      |
|------------- |--------------------------------------------- |--------------------------------- |
| `document`   | <pre>Map<String, dynamic></pre> | Document that causes the error   |
| `status`     | <pre>int</pre>                           | HTTP error status                |
| `reason`     | <pre>String</pre>                            | Human readable reason |

## Usage

With the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

<<< ./snippets/update-by-query-es.dart

With the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) syntax.

<<< ./snippets/update-by-query-koncorde.dart