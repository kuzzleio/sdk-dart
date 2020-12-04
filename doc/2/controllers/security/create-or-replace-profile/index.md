---
code: true
type: page
title: createOrReplaceProfile
description: Creates a new profile or, if the provided profile identifier already exists, replaces it.
---

# createOrReplaceProfile

Creates a new profile or, if the provided profile identifier already exists, replaces it.

<br />

```dart
Future<KuzzleProfile> createOrReplaceProfile(
      String uid, List<Map<String, dynamic>> policies,
      {bool waitForRefresh})
```

<br />
 
| Property | Type | Description |
| --- | --- | --- |
| `id` | <pre>String</pre> | Profile identifier |
| `policies` | <pre>List<Map<String, dynamic>></pre> | [Profile content](/core/2/guides/main-concepts/permissions#profiles) |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the created/replaced profile is indexed |

## Return

A [`Profile`](/sdk/dart/2/core-classes/profile/introduction) object representing the updated/created profile.

## Usage

<<< ./snippets/create-or-replace-profile.dart
