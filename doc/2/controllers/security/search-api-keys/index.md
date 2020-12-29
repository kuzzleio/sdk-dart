---
code: true
type: page
title: searchApiKeys
description: Searches for a user API keys.
---

# searchApiKeys

<SinceBadge version="Kuzzle 2.1.0" />

Searches for a user API keys.

<SinceBadge version="change-me"/>

This method also supports the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) to match documents by passing the `lang` argument with the value `koncorde`.  
Koncorde filters will be translated into an Elasticsearch query.  

::: warning
Koncorde `bool` operator and `regexp` clause are not supported for search queries.
:::

<br />

```dart
Future<SearchResult> searchApiKeys(String userId, Map<String, dynamic> query, {int from, int size, String lang})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `userId` | <pre>String</pre> | User kuid |
| `query` | <pre>Map<String, dynamic></pre> | Search query |
| `from`     | <pre>int</pre><br/>(`0`)    | Offset of the first document to fetch                  |
| `size`     | <pre>int</pre><br/>(`10`)   | Maximum number of documents to retrieve per page       |
| `lang`     | <pre>String</pre>               | Specify the query language to use. By default, it's `elasticsearch` but `koncorde` can also be used. <SinceBadge version="change-me"/> |

### query

The search query to apply to API keys content, using [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) or the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) syntax.

If left empty, the result will return all available API keys for the user.

## Returns

Returns a [SearchResult](/sdk/dart/2/core-classes/search-result) object.

## Usage

With the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

<<< ./snippets/search-api-keys-es.dart

With the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) syntax.

<<< ./snippets/search-api-keys-koncorde.dart
