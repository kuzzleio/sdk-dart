---
code: true
type: page
title: checkToken
description: Checks an authentication Token's validity.
---

# CheckToken

Checks an authentication token's validity.

## Arguments

```dart
Future<Map<String, dynamic>> checkToken(String token)
```

| Argument | Type              | Description |
|----------|-------------------|-------------|
| `token`  | <pre>String</pre> | Authentication token   |

## Return

A Map which has the following properties:

| Property     | Type              | Description                      |
|--------------|-------------------|----------------------------------|
| `valid`      | <pre>bool</pre>   | Token validity                   |
| `state`      | <pre>String</pre> | Explain why the token is invalid |
| `expires_at` | <pre>int</pre>  | Token expiration timestamp       |

## Usage

<<< ./snippets/check-token.dart
