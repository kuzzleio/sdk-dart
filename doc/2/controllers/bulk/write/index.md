---
code: true
type: page
title: write
description: Creates or replaces a document directly into the storage engine.
---

# write

Create or replace a document directly into the storage engine.

## Arguments

```dart
Future<Map<String, dynamic>> write(
      String index, 
      String collection, 
      Map<String, dynamic> document, {
        String id,
        bool waitForRefresh = false,
      })
```

| Argument     | Type               | Description                 |
|--------------|--------------------|-----------------------------|
| `index`      | <pre>String</pre>  | Index name                  |
| `collection` | <pre>String</pre>  | Collection name             |
| `content`    | <pre>Map<String, dynamic></pre> | Document content to create. |
| `id`          | <pre>String</pre><br>(`null`)  | Document id          
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)  | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing |

## Return

Returns a `Map<String, dynamic>` with the following properties:

| Property   | Type               | Description                                     |
|------------|--------------------|-------------------------------------------------|
| `_id`      | <pre>String</pre>  | Created document unique identifier. |
| `_source`  | <pre>Map<String, dynamic></pre> | Document content. |
| `_version` | <pre>int</pre> | Version number of the document |

## Usage

<<< ./snippets/write.dart
