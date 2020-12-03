---
code: true
type: page
title: query
description: Base method to send API query to Kuzzle
---

# query

Base method used to send queries to Kuzzle, following the [API Documentation](/core/2/api).

::: warning
This is a low-level method, exposed to allow advanced SDK users to bypass high-level methods.
:::

## Arguments

```dart
  Future<KuzzleResponse> query(KuzzleRequest request,
      {Map<String, dynamic> volatile, bool queueable = true})
```

<br/>

| Argument  | Type              | Description            |
| --------- | ----------------- | ---------------------- |
| `request` | <pre>KuzzleRequest</pre> | API request    |
| `volatile`   | <pre>Map<String, dynamic></pre> | Additional information to send to Kuzzle |
| `queueable`   | <pre>bool</pre> | If true, queues the request during downtime, until connected to Kuzzle again |

### request

All properties necessary for the Kuzzle API can be added in the query object.
The following properties are the most common.

| Property     | Type              | Description                              |
| ------------ | ----------------- | ---------------------------------------- |
| `controller` | <pre>String</pre> | Controller name (mandatory)              |
| `action`     | <pre>String</pre> | Action name (mandatory)                  |
| `body`       | <pre>Map<String, dynamic></pre> | Query body for this action               |
| `index`      | <pre>String</pre> | Index name for this action               |
| `collection` | <pre>String</pre> | Collection name for this action          |
| `_id`        | <pre>String</pre> | id for this action                       |
| `volatile`   | <pre>Map<String, dynamic></pre> | Additional information to send to Kuzzle |

## Returns

Returns a [KuzzleResponse](/sdk/dart/2/core-classes/response) object which represents a raw Kuzzle API response. See the [API Documentation](/core/2/api).

## Usage

<<< ./snippets/query.dart
