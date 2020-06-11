---
code: true
type: page
title: getCredentialFields
description: Retrieves the list of accepted field names by the specified authentication strategy
---

# getCredentialFields

Retrieves the list of accepted field names by the specified authentication strategy

<br />

```dart
Future<Map<String, dynamic>> getCredentialFields(String strategy)
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `strategy` | <pre>String</pre> | Strategy identifier |

## Resolves

A List of accepted field names.

## Usage

<<< ./snippets/get-credential-fields.dart
