---
code: true
type: page
title: get
description: Gets a document
---

# get

Gets a document.

---

## Arguments
 
```dart
Future<Map<String, dynamic>> get(
    String index,
    String collection,
    String id,
  )
```
 
| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `id        `       | <pre>String</pre>                            | Document ID                       |

---

## Return

A `Map<String, dynamic>` which has the following properties:

| Property     | Type                         | Description                                                    |
|------------- |----------------------------- |--------------------------------------------------------------- |
| `_source`    | <pre>Map<String, dynamic></pre> | Document content                |
| `_id`        | <pre>String</pre>            | ID of the document                                     |
| `_version`   | <pre>int</pre>           | Version of the document in the persistent data storage         |

## Usage

<<< ./snippets/get.dart
