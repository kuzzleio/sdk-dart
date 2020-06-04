---
code: true
type: page
title: GetCurrentUser
description: Returns the profile object for the user linked to the `JSON Web Token`.
---

# GetCurrentUserAsync

Returns informations about the user currently loggued with the SDK instance.

## Arguments

```dart
Future<KuzzleUser> getCurrentUser()
```

## Return

A User representing the current user logged with the SDK.

## Usage

<<< ./snippets/get-current-user.dart