---
code: true
type: page
title: constructor
description: SearchResult:constructor
order: 1
---

# SearchResults

This class represents a paginated search result.  

It can be returned by the following methods:
 - [document:search](/sdk/dart/2/controllers/document/search)
 - [collection:searchSpecifications](/sdk/dart/2/controllers/collection/search-specifications)

## Properties

| Property       | Type                                                    | Description        |
| -------------- | ------------------------------------------------------- | ------------------ |
| `aggregations` | <pre>Map<String, dynamic></pre>            | Search aggregations (can be undefined) |
| `hits`         | `List<dynamic>` | Page results       |
| `total`        | <pre>int</pre>                                      |  Total number of items that _can_ be retrieved |
| `fetched`      | <pre>int</pre>                                      | Number of retrieved items so far   |

### hits

Each element of the `hits` ArrayList is a `List<dynamic>` containing the following properties:

| Property  | Type               | Description            |
| --------- | ------------------ | ---------------------- |
| `_id`     | <pre>String</pre>  | Document ID            |
| `_score`  | <pre>int</pre> | [Relevance score](https://www.elastic.co/guide/en/elasticsearch/guide/current/relevance-intro.html) |
| `_source` | <pre>Map<String, dynamic></pre> | Document content |