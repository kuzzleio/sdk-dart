---
code: true
type: page
title: checkRights
description: Checks if the provided API request can be executed by this client, using the current authentication information.
---

# checkRights

<SinceBadge version="Kuzzle 2.8.0"/>
<SinceBadge version="auto-version"/>

Checks if the provided API request can be executed by this client, using the current authentication information.

---

```dart
Future<bool> checkRights(
    Map<String, dynamic> requestPayload)
```

| Property | Type | Description |
|--- |--- |--- |
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
