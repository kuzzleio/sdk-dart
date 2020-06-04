---
code: true
type: page
title: updateMyCredentials
description: Updates the current user's credentials for the specified strategy.
---

# UpdateMyCredentials

Updates the current user's credentials for the specified strategy. The credentials to send will depend on the authentication plugin and the authentication strategy.

## Arguments

```dart
Future<Map<String, dynamic>> updateMyCredentials(
      String strategy, Map<String, dynamic> credentials)
```

| Argument      | Type               | Description                          |
|---------------|--------------------|--------------------------------------|
| `strategy`    | <pre>String</pre>  | Strategy to use                      |
| `credentials` | <pre>Map<String, dynamic></pre> | Map representing the credentials |

## Return

A Map representing the updated credentials with the following properties:

| Property   | Type              | Description       |
|------------|-------------------|-------------------|
| `username` | <pre>String</pre> | The Username      |
| `kuid`     | <pre>String</pre> | The user's `kuid` |

## Usage

<<< ./snippets/update-my-credentials.dart
