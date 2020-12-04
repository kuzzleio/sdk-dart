---
code: true
type: page
title: mDelete
description: Deletes multiple documents
---

# mDelete

Deletes multiple documents.

---

## Arguments 

```dart
Future<Map<String, dynamic>> mDelete(
    String index,
    String collection,
    List<String> ids,
    { bool waitForRefresh = false, })
```

| Arguments          | Type                                                    | Description                       |
| ------------------ | ------------------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                                       | Index name                        |
| `collection`       | <pre>String</pre>                                       | Collection name                   |
| `ids`              | `List<String>`                            | Document IDs                      |
---

## Return

A `Map<String, dynamic>` which has a `successes` and `errors`:
The `successes` array contains the successfully deleted document IDs.

Each deletion error is an object of the errors array with the following properties:

| Property     | Type                                         | Description                      |
|------------- |--------------------------------------------- |--------------------------------- |
| `_id`        | <pre>String</pre>                            | Document ID                      |
| `reason`     | <pre>String</pre>                            | Human readable reason            |

## Usage

<<< ./snippets/m-delete.dart
