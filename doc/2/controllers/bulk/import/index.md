---
code: true
type: page
title: import
description: Creates, updates or deletes large amounts of documents as fast as possible.
---

# Import

Creates, updates or deletes large amounts of documents as fast as possible.

This route is faster than the `document:m*` routes family (e.g. [document:mCreate](/sdk/dart/2/controllers/document/m-create)), but no real-time notifications will be generated, even if some of the documents in the import match subscription filters.

## Arguments

```dart
Future<Map<String, dynamic>> import(
      String index, String collection, List<Map<String, dynamic>> documents)
```

| Argument     | Type              | Description                                                  |
|--------------|-------------------|--------------------------------------------------------------|
| `index`      | <pre>String</pre> | Index name                                                   |
| `collection` | <pre>String</pre> | Collection name                                              |
| `documents`   | <pre>List<Map<String, dynamic>></pre> | List of documents to import |

### documents

This API takes a JSON array containing a list of objects working in pairs.
In each pair, the first object specifies the action to perform (the most common is `create`) and the second specifies the document itself, like in the example below:

```json
[
  // Action object
  { "create": { "_id": "id" } },
  // Document object
  { "myField": "myValue", "myOtherField": "myOtherValue" },

  // Another action object
  { "create": { "_id": "another-id" } },
  // Another document object
  { "myField": "anotherValue", "myOtherField": "yetAnotherValue" }
];
```

Possible actions are `create`, `index`, `update`, `delete`.

Learn more at [Elasticsearch Bulk API](https://www.elastic.co/guide/en/elasticsearch/reference/7.4/docs-bulk.html)

## Return

A Map<String, dynamic> containing 2 arrays:

| Property | Type                | Description                                         |
| -------- | ------------------- | --------------------------------------------------- |
| `successes`  | `List<dynamic>` | Array of object containing successful document import |
| `errors` | `List<dynamic>`  | Array of object containing failed document import     |

Each item of the `successes` array is an object containing the action name as key and the corresponding object contain the following properties:

| Property | Type                | Description                                         |
| -------- | ------------------- | --------------------------------------------------- |
| `_id`   | <pre>String</pre>   | Document unique identifier      |
| `status`   | <pre>int</pre>   | HTTP status code for that query      |

Each item of the `errors` array is an object containing the action name as key and the corresponding object contain the following properties:

| Property | Type                | Description                                         |
| -------- | ------------------- | --------------------------------------------------- |
| `_id`   | <pre>String</pre>   | Document unique identifier      |
| `status`   | <pre>int</pre>   | HTTP status code for that query      |
| `error`   | <pre>Map<String, dynamic></pre>   | Error object      |

Each `error` object contain the following properties:

| Property | Type                | Description                                         |
| -------- | ------------------- | --------------------------------------------------- |
| `type`  | <pre>String</pre> | Elasticsearch client error type |
| `reason`  | <pre>String</pre> | human readable error message |

## Usage

<<< ./snippets/import.dart