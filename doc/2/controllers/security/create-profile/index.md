---
code: true
type: page
title: createProfile
description: Creates a new profile
---

# createProfile

Creates a new profile.

<br />

```dart
Future<KuzzleProfile> createProfile(
    String uid, List<Map<String, dynamic>> policies,
    {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | Profile identifier |
| `policies` | <pre>List<Map<String, dynamic>></pre> | [Profile content](/core/2/guides/main-concepts/permissions#profiles) |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the created profile is indexed |

## Return

A [`Profile`](/sdk/dart/2/core-classes/profile/introduction) object representing the created profile.

## Usage

<<< ./snippets/create-profile.dart
