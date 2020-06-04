---
code: true
type: page
title: update
description: Updates a document
---

# update

Updates a document.

---

## Arguments
 
```dart
Future<Map<String, dynamic>> update(
    String index,
    String collection,
    String id,
    Map<String, dynamic> document, {
    bool waitForRefresh = false,
    int retryOnConflict,
    bool source,
  })
```

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `id        `       | <pre>String</pre>                            | Document ID                        |
| `document`         | <pre>Map<String, dynamic></pre> | Partial document content |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                           | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing|
| `retryOnConflict`  | <pre>int</pre><br>(`null`)                           | The number of times the database layer should retry in case of version conflict |
| `source`           | <pre>bool</pre><br>(`false`)                           | If true, returns the updated document inside the response |


---

## Return

A `Map<String, dynamic>` which has the following properties:

| Property     | Type                         | Description                                                    |
|------------- |----------------------------- |--------------------------------------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Updated document (If source option set to true)                |
| `_id`        | <pre>String</pre>            | ID of the updated document                                     |
| `_version`   | <pre>int</pre>           | Version of the document in the persistent data storage         |

## Usage

<<< ./snippets/update.dart
