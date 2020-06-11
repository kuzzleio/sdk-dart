---
code: true
type: page
title: getAllCredentialFields
description: Retrieves the list of fields accepted by authentication strategies.
---

# getAllCredentialFields

Retrieves the list of fields accepted by authentication strategies.

<br />

```dart
Future<Map<String, dynamic>> getAllCredentialFields()
```

## Return

An object with one property set per authentication strategy, each being an array of accepted field names.

## Usage

<<< ./snippets/get-all-credential-fields.dart
