---
code: false
type: page
title: Introduction
description: KuzzleRequest object description
order: 0
---

## KuzzleRequest

`KuzzleRequest` is a **serializable** class representing a raw Kuzzle request.

## Properties

| Property         | Type                        | Description                                                                                                                                                                                                      |
| ---------------- | --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `action`         | `String`                    | Executed Kuzzle API controller's action                                                                                                                                                                          |
| `body`           | `Map<String, dynamic> body` |                                                                                                                                                                                                                  |
| `collection`     | `String`                    | Impacted collection                                                                                                                                                                                              |
| `controller`     | `String`                    | Executed Kuzzle API controller                                                                                                                                                                                   |
| `index`          | `String`                    | Impacted index                                                                                                                                                                                                   |
| `jwt`            | `String`                    | Authentication token                                                                                                                                                                                             |
| `lang`           | `String`                    | ES lang                                                                                                                                                                                                          |
| `requestId`      | `String`                    | Request unique identifier                                                                                                                                                                                        |
| `waitForRefresh` | `bool`                      | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing                                                                                                                                  |
| `volatile`       | `Map<String, dynamic>`      | Volatile data                                                                                                                                                                                                    |
| `from`           | `int`<br/>(`0`)             | Offset of the first document to fetch                                                                                                                                                                            |
| `size`           | `int`<br/>(`10`)            | Maximum number of documents to retrieve per page                                                                                                                                                                 |
| `scroll`         | `String`<br/>(`""`)         | When set, gets a forward-only cursor having its ttl set to the given value (ie `1s`; cf [elasticsearch time limits](https://www.elastic.co/guide/en/elasticsearch/reference/7.3/common-options.html#time-units)) |
| `scrollId`       | `String`                    | The scrollId if using scroll option                                                                                                                                                                              |
| `sort`           | `List<dynamic>`             | Contains a list of fields, used to [sort search results](https://www.elastic.co/guide/en/elasticsearch/reference/7.3/search-request-sort.html), in order of importance.                                          |

## Overrided operators

The `[]` and `[]=` are overrided so you can dynamically add any args you want to this class and it will be taken in consideration in the request sent to Kuzzle.
