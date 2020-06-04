---
code: true
type: page
title: exists
description: Checks if a document exists
---

# exists

Checks if a document exists.

---

## Arguments

```dart
Future<bool> exists(String index, String collection, String id)
```

---

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `id      `         | <pre>String</pre>                            | Document ID |


---

## Return

Returns a boolean.

## Usage

<<< ./snippets/exists.dart