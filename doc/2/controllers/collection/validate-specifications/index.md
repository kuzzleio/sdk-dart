---
code: true
type: page
title: validateSpecifications
description: Validate specifications format
---

# validateSpecifications

The validateSpecifications method checks if a validation specification is well formatted. It does not store or modify the existing specification.

When the validation specification is not formatted correctly, a detailed error message is returned to help you fix it.

<br/>

```dart
Future<bool> validateSpecifications(
    String index,
    String collection,
    bool strict,
    Map<String, dynamic> fields,
  )
```

<br/>

| Arguments        | Type                                         | Description                |
| ---------------- | -------------------------------------------- | -------------------------- |
| `index`          | <pre>String</pre>                            | Index name                 |
| `collection`     | <pre>String</pre>                            | Collection name            |
| `specifications` | <pre>Map<String, dynamic></pre> | Specifications to validate |

### specifications

A `Map<String, dynamic>` representing the specifications.

This object must follow the [Specification Structure](/core/2/guides/advanced/data-validation).

## Returns

Returns a `bool` which contains information about the specifications validity.

## Usage

<<< ./snippets/validate-specifications.dart
