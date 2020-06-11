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

<br />

| Property | Type | Description |
|--- |--- |--- |
| `query` | <pre>Map<String, dynamic></pre> | Search query |
| `from`     | <pre>int</pre><br/>(`0`)     | Offset of the first document to fetch            |
| `size`     | <pre>int</pre><br/>(`10`)    | Maximum number of documents to retrieve per page |
| `scroll`   | <pre>String</pre><br/>(`""`)    | When set, gets a forward-only cursor having its ttl set to the given value (ie `30s`; cf [elasticsearch time limits](https://www.elastic.co/guide/en/elasticsearch/reference/7.3/common-options.html#time-units)) |

### query

The search query to apply to users content, using [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

If left empty, the result will return all available users.

## Return

A [`UserSearchResult`](sdk/dart/2/core-classes/search-result) object containing the retrieved [`User`](/sdk/dart/2/core-classes/user) objects.

## Usage

<<< ./snippets/search-users.dart
