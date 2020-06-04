---
code: true
type: page
title: delete
description: Deletes a document
---

# delete

Deletes a document.

---

## Arguments

```dart
Future<void> delete(
    String index,
    String collection,
    String id, {
    bool waitForRefresh = false,
  })
```

| Arguments          | Type                                         | Description                       |
| ------------------ | -------------------------------------------- | --------------------------------- |
| `index`            | <pre>String</pre>                            | Index                             |
| `collection`       | <pre>String</pre>                            | Collection                        |
| `id      `         | <pre>String</pre>                            | Document ID |
| `waitForRefresh`   | <pre>bool</pre><br>(`false`)                | If set to `true`, Kuzzle will wait for the persistence layer to finish indexing|

---

## Usage

<<< ./snippets/delete.dart
