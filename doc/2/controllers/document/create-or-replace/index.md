---
code: true
type: page
title: createOrReplace
description: Creates or replaces a document
---

# createOrReplace

Creates a new document in the persistent data storage, or replaces its content if it already exists.

---

## Arguments

```dart
Future<Map<String, dynamic>> createOrReplace(
    String index,
    String collection,
    String id,
    Map<String, dynamic> document, {
    bool waitForRefresh = false,
  })
```

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `id`               | <pre>String</pre>                            | Document ID                       |
| `document`         | <pre>Map<String, dynamic></pre> | Document content                  |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                           | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing|

---

## Return

A `Map<String, dynamic>` which has the following properties:

| Property     | Type                         | Description                      |
|------------- |----------------------------- |--------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Document content                 |
| `_id`        | <pre>String</pre>            | ID of the document                       |
| `_version`   | <pre>int</pre>           | Version of the document in the persistent data storage |

## Usage

<<< ./snippets/create-or-replace.dart
