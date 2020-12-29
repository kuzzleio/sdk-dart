---
code: true
type: page
title: searchUsers
description: Searches users
---

# searchUsers

Searches users.

<br />

```dart
Future<UserSearchResult> searchUsers(
      {Map<String, dynamic> query, int from, int size, String scroll})
```

<SinceBadge version="change-me"/>

This method also supports the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) to match documents by passing the `lang` argument with the value `koncorde`.  
Koncorde filters will be translated into an Elasticsearch query.  

::: warning
Koncorde `bool` operator and `regexp` clause are not supported for search queries.
:::

<br />

| Property | Type | Description |
|--- |--- |--- |
| `query` | <pre>Map<String, dynamic></pre> | Search query |
| `from`     | <pre>int</pre><br/>(`0`)     | Offset of the first document to fetch            |
| `size`     | <pre>int</pre><br/>(`10`)    | Maximum number of documents to retrieve per page |
| `scroll`   | <pre>String</pre><br/>(`""`)    | When set, gets a forward-only cursor having its ttl set to the given value (ie `30s`; cf [elasticsearch time limits](https://www.elastic.co/guide/en/elasticsearch/reference/7.3/common-options.html#time-units)) |
| `lang`     | <pre>String</pre>               | Specify the query language to use. By default, it's `elasticsearch` but `koncorde` can also be used. <SinceBadge version="change-me"/> |

### query

The search query to apply to users content, using [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) or the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) syntax.

If left empty, the result will return all available users.

## Return

A [`UserSearchResult`](sdk/dart/2/core-classes/search-result) object containing the retrieved [`User`](/sdk/dart/2/core-classes/user) objects.

## Usage

With the [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

<<< ./snippets/search-users-es.dart

With the [Koncorde Filters DSL](/core/2/api/koncorde-filters-syntax) syntax.

<<< ./snippets/search-users-koncorde.dart