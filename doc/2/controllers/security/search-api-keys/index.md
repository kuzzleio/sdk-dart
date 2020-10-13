---
code: true
type: page
title: searchApiKeys
description: Searches for a user API keys.
---

# searchApiKeys

<SinceBadge version="Kuzzle 2.1.0" />

Searches for a user API keys.

<br />

```dart
Future<SearchResult> searchApiKeys(String userId, Map<String, dynamic> query, {int from, int size})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `userId` | <pre>String</pre> | User kuid |
| `query` | <pre>Map<String, dynamic></pre> | Search query |
| `from`     | <pre>int</pre><br/>(`0`)    | Offset of the first document to fetch                  |
| `size`     | <pre>int</pre><br/>(`10`)   | Maximum number of documents to retrieve per page       |

### query

The search query to apply to API keys content, using [ElasticSearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/query-dsl.html) syntax.

If left empty, the result will return all available API keys for the user.

## Returns

Returns a [SearchResult](/sdk/dart/2/core-classes/search-result) object.

## Usage

<<< ./snippets/search-api-keys.dart
