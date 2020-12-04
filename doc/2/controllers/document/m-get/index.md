---
code: true
type: page
title: mGet
description: Gets multiple documents
---

# mGet

Gets multiple documents.

---

## Arguments 

```dart
Future<Map<String, dynamic>> mGet(
    String index,
    String collection,
    List<String> ids,
  )
```

| Arguments          | Type                                                    | Description                       |
| ------------------ | ------------------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                                       | Index name                        |
| `collection`       | <pre>String</pre>                                       | Collection name                   |
| `ids`              | `List<String>`                            | Document IDs                      |
---

## Return

A `Map<String, dynamic>` which has a `successes` and `errors`:
Each created document is an object of the `successes` array with the following properties:

| Property     | Type                                         | Description                      |
|------------- |--------------------------------------------- |--------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Document content                 |
| `_id`        | <pre>String</pre>                            | Document ID                      |
| `_version`   | <pre>int</pre>                           | Version of the document in the persistent data storage |

The `errors` array contains the IDs of not found documents.

## Usage

<<< ./snippets/m-get.dart
