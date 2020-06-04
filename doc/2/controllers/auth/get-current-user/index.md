---
code: true
type: page
title: getCurrentUser
description: Returns the profile object for the user linked to the `JSON Web Token`.
---

# GetCurrentUser

Returns informations about the user currently loggued with the SDK instance.

## Arguments

```dart
Future<KuzzleUser> getCurrentUser()
```

## Return

A [User](/sdk/dart/2/core-classes/user) representing the current user logged with the SDK.

## Usage

<<< ./snippets/get-current-user.dart
