---
code: true
type: page
title: createMyCredentials
description: Create the current user's credentials for the specified strategy.
---

# CreateMyCredentials

Creates the current user's credentials for the specified strategy.

## Arguments

```dart
Future<Map<String, dynamic>> createMyCredentials(
    String strategy, {
    Map<String, dynamic> credentials,
  })
```

| Argument      | Type               | Description                          |
|---------------|--------------------|--------------------------------------|
| `strategy`    | <pre>String</pre>  | Strategy to use                      |
| `credentials` | <pre>Map<String, dynamic></pre> | Map representing the credentials |

## Return

A ConcurrentHashMap representing the new credentials.

## Usage

<<< ./snippets/create-my-credentials.dart
