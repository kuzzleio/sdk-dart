---
code: true
type: page
title: mReplace
description: Replaces multiple documents
---

# mReplace

Replaces multiple documents.

---

## Arguments

```dart
Future<Map<String, dynamic>> mReplace(
    String index,
    String collection,
    List<Map<String, dynamic>> documents,
    { bool waitForRefresh = false, })
```

| Arguments          | Type                                                    | Description                       |
| ------------------ | ------------------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                                       | Index                             |
| `collection`       | <pre>String</pre>                                       | Collection                        |
| `documents`        | <pre>List<Map<String, dynamic>></pre> | List containing the documents to replace |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                                      | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing |

---

### documents

Each document has the following properties:

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `_id`              | <pre>String</pre>                            | Optional document ID. Will be auto-generated if not defined.             |
| `body`             | <pre>Map<String, dynamic></pre> | Document body |

## Return

A `Map<String, dynamic>` which has a `successes` and `errors`:
Each created document is an object of the `successes` array with the following properties:

| Property     | Type                                         | Description                      |
|------------- |--------------------------------------------- |--------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Created document                 |
| `_id`        | <pre>String</pre>                            | ID of the replaced document      |
| `_version`   | <pre>int</pre>                           | Version of the document in the persistent data storage |

Each errored document is an object of the `errors` array with the following properties:

| Property     | Type                                         | Description                      |
|------------- |--------------------------------------------- |--------------------------------- |
| `document`   | <pre>Map<String, dynamic></pre> | Document that causes the error   |
| `status`     | <pre>int</pre>                           | HTTP error status                |
| `reason`     | <pre>String</pre>                            | Human readable reason |

## Usage

<<< ./snippets/m-replace.dart
