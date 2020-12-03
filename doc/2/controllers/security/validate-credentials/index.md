---
code: true
type: page
title: validateCredentials
description: Checks if the provided credentials are well-formed. Does not actually save credentials.
---

# validateCredentials

Checks if the provided credentials are well-formed. Does not actually save credentials.

<br />

```dart
Future<bool> validateCredentials(
      String strategy, String id, Map<String, dynamic> credentials)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `strategy` | <pre>String</pre> | Strategy identifier |
| `id` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `credentials` | <pre>Map<String, dynamic></pre> | New credentials |

### credentials

The credentials to check. The expected properties depend on the target authentication strategy.

Example for the `local` strategy:

```dart
{
  'username': 'foo',
  'password': 'bar'
}
```

## Return

A | <pre>bool</pre> telling whether credentials are valid.

## Usage

<<< ./snippets/validate-credentials.dart
