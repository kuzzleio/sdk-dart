---
code: true
type: page
title: updateProfile
description: Updates a security profile definition
---

# updateProfile

Updates a security profile definition.

<br />

```dart
 Future<KuzzleProfile> updateProfile(String id, List<dynamic> policies,
      {bool? waitForRefresh})
```

<br />

| Property         | Type                  | Description                                                                     |
| ---------------- | --------------------- | ------------------------------------------------------------------------------- |
| `id`             | `String`              | Profile identifier                                                              |
| `policies`       | `List<dynamic>`       | [Profile definition content](/core/2/guides/main-concepts/permissions#profiles) |
| `waitForRefresh` | `bool?`<br />(`null`) | If set to `true`, Kuzzle will not respond until the created profile is indexed  |

## Return

A [`Profile`](/sdk/dart/3/core-classes/profile/introduction) object representing the updated profile.

## Usage

<<< ./snippets/update-profile.dart
