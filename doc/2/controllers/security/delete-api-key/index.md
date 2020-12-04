---
code: true
type: page
title: deleteApiKey
description: Deletes a user's API key.
---

# deleteApiKey

<SinceBadge version="7.1.0" />

<SinceBadge version="Kuzzle 2.1.0" />

Deletes a user's API key.

<br />

```dart
Future<Null> deleteApiKey(
      String userId, String id, {bool waitForRefresh})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `userId` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `id` | <pre>String</pre> | API key unique ID |
| `refresh` | <pre>bool</pre><br />(`false`) | If set to `wait_for`, Kuzzle will not respond until the API key is indexed |

## Usage

<<< ./snippets/delete-api-key.dart
