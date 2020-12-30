---
code: true
type: page
title: upsert
description: Applies partial changes to a document. If the document doesn't already exist, a new document is created.
---

# upsert

<SinceBadge version="Kuzzle 2.8.0"/>
<SinceBadge version="auto-version" />

Applies partial changes to a document. If the document doesn't already exist, a new document is created.


```dart
  Future<Map<String, dynamic>> upsert(
    String index,
    String collection,
    String id,
    Map<String, dynamic> changes, {
    bool waitForRefresh = false,
    int retryOnConflict,
    bool source,
  })
```

| Argument     | Type              | Description                               |
| ------------ | ----------------- | ----------------------------------------- |
| `index`      | <pre>String</pre> | Index name                                |
| `collection` | <pre>String</pre> | Collection name                           |
| `id`         | <pre>String</pre> | Document ID                               |
| `changes`       | <pre>Map<String, dynamic></pre> | Partial content of the document to update |

### Options

Additional query options

| Options           | Type<br/>(default)              | Description                                                                        |
| ----------------- | ------------------------------- | ---------------------------------------------------------------------------------- |
| `defaults` | <pre>Map<String, dynamic></pre><br/>(`{}`)  | (optional) fields to add to the document if it gets created  |
| `waitForRefresh`         | <pre>bool</pre><br/>(`""`)    | If set to `true`, waits for the change to be reflected for `search` (up to 1s) |
| `retryOnConflict` | <pre>int</pre><br/>(`10`)        | The number of times the database layer should retry in case of version conflict    |
| `source`          | <pre>bool</pre><br/>(`false`)| If true, returns the updated document inside the response


## Returns

A `Map<String, dynamic>` with the following properties:

| Property     | Type                                         | Description                      |
|------------- |--------------------------------------------- |--------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Updated document (if `source` option set to true)  |
| `_id`        | <pre>String</pre>                            | ID of the udated document                   |
| `_version`   | <pre>int</pre>                           | Version of the document in the persistent data storage |
| `created`     | <pre>bool</pre> | If `true`, a new document was created, otherwise the document existed and was updated |

## Usage

<<< ./snippets/upsert.dart
