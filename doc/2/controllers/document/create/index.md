---
code: true
type: page
title: create
description: Creates a new document
---

# create

Creates a new document in the persistent data storage.

Throws an error if the document already exists.

The optional parameter `waitForRefresh` can be used with the value `true` in order to wait for the document to be indexed (indexed documents are available for `search`).

---

## Arguments

```dart
Future<Map<String, dynamic>> create(
    String index,
    String collection,
    Map<String, dynamic> document, {
    String id,
    bool waitForRefresh = false,
  })
```

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `document`         | <pre>Map<String, dynamic></pre> | Document content |
| `id`          | <pre>String</pre><br>(`null`)         | Document id               |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                           | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing|

---

## Return

A `Map<String, dynamic>` which has the following properties:

| Property     | Type                         | Description                      |
|------------- |----------------------------- |--------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Created document                 |
| `_id`        | <pre>String</pre>            | ID of the newly created document                       |
| `_version`   | <pre>int</pre>           | Version of the document in the persistent data storage |

## Usage

<<< ./snippets/create.dart
