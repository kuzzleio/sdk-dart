---
code: true
type: page
title: credentialsExist
description: Checks that the current user has credentials for the specified strategy.
---

# CredentialsExist

Checks that the current user has credentials for the specified strategy.

## Arguments

```dart
Future<bool> credentialsExist(String strategy)
```

| Argument   | Type              | Description     |
|------------|-------------------|-----------------|
| `strategy` | <pre>String</pre> | Strategy to use |

## Return

A boolean indicating if credentials exist for the strategy.

## Usage

<<< ./snippets/credentials-exist.dart
