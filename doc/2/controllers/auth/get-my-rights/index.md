---
code: true
type: page
title: getMyRights
description: Returns the rights for the user linked to the `JSON Web Token`.
---

# GetMyRights

Returns the rights for the currently logged in user within the SDK instance.

## Arguments

```dart
Future<List<Map<String, dynamic>>> getMyRights()
```

## Return

A List.

## Usage

<<< ./snippets/get-my-rights.dart
