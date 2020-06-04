---
code: true
type: page
title: list
description: Returns the collection list of an index
---

# list

Returns the list of collections associated to a provided index.
The returned list is sorted in alphanumerical order.

<br/>

```dart
Future<Map<String, dynamic>> list(
    String index, {int from, int size, String type})
```


| Arguments | Type                   | Description   |
| --------- | ---------------------- | ------------- |
| `index`   | <pre>String</pre>      | Index name    |

## Returns

Returns a `ConcurrentHashMap<String, Object>` containing the following properties:

| Property      | Type                | Description                                                        |
| ------------- | ------------------- | ------------------------------------------------------------------ |
| `type`        | <pre>String</pre>   | Types of returned collections <br/>(`all`, `realtime` or `stored`) |
| `from`        | <pre>int</pre>   | Offset of the first result                                         |
| `size`        | <pre>int</pre>   | Maximum number of returned results                                 |

Each object in the `collections` array contains the following properties:

| Property | Type              | Description                              |
| -------- | ----------------- | ---------------------------------------- |
| `name`   | <pre>String</pre> | Collection name                          |
| `type`   | <pre>String</pre> | Collection type (`realtime` or `stored`) |

## Usage

<<< ./snippets/list.dart