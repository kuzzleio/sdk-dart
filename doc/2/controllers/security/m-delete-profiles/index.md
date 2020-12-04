---
code: true
type: page
title: mDeleteProfiles
description: Deletes multiple security profiles.
---

# mDeleteProfiles

Deletes multiple security profiles.

Throws a partial error (error code 206) if one or more profile deletions fail.

<br />

```dart
Future<List<dynamic>> mDeleteProfiles(List<String> ids, {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `ids` | `List<String>` | Profile identifiers |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the profiles deletion is indexed |

## Return

A List of the deleted profile ids.

## Usage

<<< ./snippets/m-delete-profiles.dart

