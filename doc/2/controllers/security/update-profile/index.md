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
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | Profile identifier |
| `policies` | <pre>List<dynamic></pre> | [Profile definition content](/core/2/guides/main-concepts/permissions#profiles) |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the created profile is indexed |

## Return

A [`Profile`](/sdk/dart/2/core-classes/profile/introduction) object representing the updated profile.

## Usage

<<< ./snippets/update-profile.dart
