---
code: true
type: page
title: updateSpecifications
description: Update the validation specifications
---

# updateSpecifications

The updateSpecifications method allows you to create or update the validation specifications for a collection.

When the validation specification is not formatted correctly, a detailed error message is returned to help you fix it.

<br/>

```dart
Future<Map<String, dynamic>> updateSpecifications(
    String index,
    String collection,
    bool strict,
    Map<String, dynamic> specifications,
  )
```

<br/>

| Arguments        | Type                                         | Description              |
| ---------------- | -------------------------------------------- | ------------------------ |
| `index`          | <pre>String</pre>                            | Index name               |
| `collection`     | <pre>String</pre>                            | Collection name          |
| `specifications` | <pre>Map<String, dynamic></pre> | Specifications to update |

### specifications

A `Map<String, dynamic>` representing the specifications.

It must follow the [Specification Structure](/core/2/guides/advanced/data-validation).

## Returns

Returns a `Map<String, dynamic>` containing the specifications.

## Usage

<<< ./snippets/update-specifications.dart
