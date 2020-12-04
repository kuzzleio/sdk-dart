---
code: true
type: page
title: mWrite
description: Creates or replaces multiple documents directly into the storage engine.
---

# mWrite

This is a low level route intended to bypass Kuzzle actions on document creation, notably:
  - check [document validity](/core/2/guides/advanced/data-validation),
  - add [kuzzle metadata](/core/2/guides/main-concepts/data-storage#kuzzle-metadata),
  - trigger [realtime notifications](/core/2/guides/main-concepts/realtime-engine) (unless asked otherwise)

## Arguments

```dart
Future<Map<String, dynamic>> import(
      String index, 
      String collection, 
      List<Map<String, dynamic>> documents,
      {
        bool waitForRefresh = false,
      })
```

| Argument     | Type              | Description                                                                                                                      |
|--------------|-------------------|----------------------------------------------------------------------------------------------------------------------------------|
| `index`      | <pre>String</pre> | Index name                                                                                                                       |
| `collection` | <pre>String</pre> | Collection name                                                                                                                  |
| `documents`  | <pre>List<Map<String, dynamic>></pre> | An array of Map<String, dynamic> representing the documents|
| `waitForRefresh` | <pre>bool</pre><br>(`false`) | If set to true, Kuzzle will not respond until the created/replaced documents are indexed |

### documents

An array of `Map<String, dynamic>`. Each object describes a document to create or replace, by exposing the following properties:
  - `_id`: document unique identifier (optional)
  - `body`: document content

## Return

Returns a `Map<String, dynamic>` containing 2 arrays: `successes` and `errors`

Each created or replaced document is an object of the `successes` array with the following properties:

| Name      | Type              | Description                                            |
| --------- | ----------------- | ------------------------------------------------------ |
| `_id`      | <pre>String</pre> | Document ID                     |
| `_version` | <pre>int</pre> | Version of the document in the persistent data storage |
| `_source`  | <pre>Map<String, dynamic></pre> | Document content                                       |
| `created`  | <pre>bool</pre> | True if the document was created |

Each errored document is an object of the `errors` array with the following properties:

| Name      | Type              | Description                                            |
| --------- | ----------------- | ------------------------------------------------------ |
| `document`  | <pre>Map<String, dynamic></pre> | Document that cause the error                                       |
| `status` | <pre>int</pre> | HTTP error status |
| `reason`  | <pre>String</pre> | Human readable reason |

## Usage

<<< ./snippets/mwrite.dart
