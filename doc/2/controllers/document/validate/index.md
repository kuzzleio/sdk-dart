---
code: true
type: page
title: validate
description: Validate a document
---

# validate

Validates data against existing validation rules.

Note that if no validation specifications are set for the `<index>`/`<collection>`, the document will always be valid.

This request does **not** store or publish the document.

<br/>

```dart
Future<bool> validate(
    String index,
    String collection,
    Map<String, dynamic> document,
  )
```

| Argument     | Type                                         | Description          |
| ------------ | -------------------------------------------- | -------------------- |
| `index`      | <pre>String</pre>                            | Index name           |
| `collection` | <pre>String</pre>                            | Collection name      |
| `document`   | <pre>Map<String, dynamic></pre> | Document to validate |

## Returns

Returns a boolean value set to true if the document is valid and false otherwise.

## Usage

<<< ./snippets/validate.dart