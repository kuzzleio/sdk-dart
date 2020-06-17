---
code: true
type: page
title: deleteProfile
description: Deletes a security profile
---

# deleteProfile

Deletes a security profile.

<br />

```dart
 Future<Map<String, dynamic>> deleteProfile(String id,
  {bool waitForRefresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `id` | <pre>String</pre> | Profile identifier |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the profile deletion is indexed |

## Return

An object containing the `kuid` of the deleted profile in its `_id` property.

## Usage

<<< ./snippets/delete-profile.dart
