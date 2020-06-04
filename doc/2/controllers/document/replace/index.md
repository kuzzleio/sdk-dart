---
code: true
type: page
title: replace
description: Replaces a document
---

# replace

Replaces the content of an existing document.

---

## Arguments

```dart
Future<Map<String, dynamic>> replace(
    String index,
    String collection,
    String id,
    Map<String, dynamic> document,
    { bool waitForRefresh = false, })
```

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `id`               | <pre>String</pre>                            | Document ID                       |
| `document`         | <pre>Map<String, dynamic></pre> | New content of the document to update |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                 | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing|

---

## Return

A `Map<String, dynamic>` which has the following properties:

| Property     | Type                         | Description                      |
|------------- |----------------------------- |--------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Document content                 |
| `_id`        | <pre>String</pre>            | ID of the document                       |
| `_version`   | <pre>int</pre>           | Version of the document in the persistent data storage |

## Usage

<<< ./snippets/replace.dart
