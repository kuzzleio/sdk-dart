---
code: true
type: page
title: searchRoles
description: Searches security roles, optionally returning only those allowing access to the provided controllers.
---

# searchRoles

Searches security roles, optionally returning only those allowing access to the provided controllers.

<br />

```dart
Future<RoleSearchResult> searchRoles(
      {Map<String, dynamic> query, int from, int size, String scroll})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `query` | <pre>Map<String, dynamic></pre> | Query including allowed controllers to search for |
| `from`     | <pre>int</pre><br/>(`0`)     | Offset of the first document to fetch    |
| `size`     | <pre>int</pre><br/>(`10`)    | Maximum number of documents to retrieve per page |
| `scroll`   | <pre>String</pre><br/>(`""`)    | When set, gets a forward-only cursor having its ttl set to the given value (ie `30s`; cf [elasticsearch time limits](https://www.elastic.co/guide/en/elasticsearch/reference/7.3/common-options.html#time-units)) |

### query

| Property | Type | Description |
| --- | --- | --- |
| `controllers` | <pre>List<String></pre> | Role identifiers |

## Return

A [`RoleSearchResult`](sdk/dart/2/core-classes/search-result) object containing the retrieved [`Role`](/sdk/dart/2/core-classes/role) objects.

## Usage

<<< ./snippets/search-roles.dart
