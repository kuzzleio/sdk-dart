---
code: true
type: page
title: validateMyCredentials
description: Validates the current user's credentials for the specified strategy.
---

# ValidateMyCredentials

Validates the current user's credentials for the specified strategy. This method returns `true` if the provided credentials are valid; otherwise an error is triggered. This route does not actually create or modify the user credentials. The credentials to send will depend on the authentication plugin and authentication strategy.

## Arguments

```dart
Future<bool> validateMyCredentials(
      String strategy, Map<String, dynamic> credentials)
```

| Argument      | Type               | Description                          |
|---------------|--------------------|--------------------------------------|
| `strategy`    | <pre>String</pre>  | Strategy to use                      |
| `credentials` | <pre>Map<String, dynamic></pre> | A Map representing the credentials |

## Return

A boolean indicating if the credentials are valid.

## Usage

<<< ./snippets/validate-my-credentials.dart
