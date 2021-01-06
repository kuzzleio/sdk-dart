---
code: true
type: page
title: checkRights
description: Checks if an API action can be executed by the current user
---

# checkRights

<SinceBadge version="2.8.0"/>

Checks if the provided API request can be executed by the current user.

---

```dart
Future<bool> checkRights(
    String kuid, Map<String, dynamic> requestPayload)
```

| Property | Type | Description |
|--- |--- |--- |
| `kuid` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `requestPayload` | <pre>Map<String, dynamic></pre> | Contains a [RequestPayload](/core/2/api/payloads/request) |

## `requestPayload`

The [RequestPayload](/core/2/api/payloads/request) must contain at least the following properties:

- `controller`: API controller
- `action`: API action

---

## Returns

Returns a boolean telling whether the provided request is allowed or not.

## Usage

<<< ./snippets/check-rights.dart
