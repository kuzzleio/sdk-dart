---
code: true
type: page
title: searchProfiles
description: Searches security profiles, optionally returning only those linked to the provided list of security roles
---

# searchProfiles

Searches security profiles, optionally returning only those linked to the provided list of security roles.

<br />

```dart
Future<ProfileSearchResult> searchProfiles(
      {Map<String, dynamic> query, int from, int size, String scroll})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `query` | <pre>Map<String, dynamic></pre> | Query including role identifiers to search for |
| `from`     | <pre>int</pre><br/>(`0`)     | Offset of the first document to fetch |
| `size`     | <pre>int</pre><br/>(`10`)    | Maximum number of documents to retrieve per page |
| `scroll`   | <pre>String</pre><br/>(`""`)    | When set, gets a forward-only cursor having its ttl set to the given value (ie `30s`; cf [elasticsearch time limits](https://www.elastic.co/guide/en/elasticsearch/reference/7.3/common-options.html#time-units)) |

### query

| Property | Type | Description |
| --- | --- | --- |
| `roles` | `List<String>` | Role identifiers |


## Return

A [`ProfileSearchResult`](sdk/dart/2/core-classes/search-result) object containing the retrieved [`Profile`](/sdk/dart/2/core-classes/profile) objects.

## Usage

<<< ./snippets/search-profiles.dart
