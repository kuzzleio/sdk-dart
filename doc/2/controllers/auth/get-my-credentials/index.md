---
code: true
type: page
title: getMyCredentials
description: Returns the current user's credential information for the specified strategy.
---

# GetMyCredentials

Returns the current user's credential information for the specified strategy. The data returned will depend on the specified strategy. The result can be empty.

## Arguments

```dart
Future<Map<String, dynamic>> getMyCredentials(String strategy)
```

| Argument   | Type              | Description     |
|------------|-------------------|-----------------|
| `strategy` | <pre>String</pre> | Strategy to use |

## Return

Returns a Map representing the credentials for the provided authentication strategy.

## Usage

<<< ./snippets/get-my-credentials.dart
