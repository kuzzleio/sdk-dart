---
code: true
type: page
title: mGetProfiles
description: Gets multiple security profiles
---

# mGetProfiles

Gets multiple security profiles.

<br />

```dart
Future<List<KuzzleProfile>> mGetProfiles(List<String> ids)
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `ids` | `List<String>` | Profile identifiers |

## Return

An List of retrieved [`Profile`](/sdk/dart/2/core-classes/profile/introduction) objects.

## Usage

<<< ./snippets/m-get-profiles.dart
