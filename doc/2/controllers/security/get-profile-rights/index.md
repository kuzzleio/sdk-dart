---
code: true
type: page
title: getProfileRights
description: Gets the detailed rights configured by a security profile
---

# getProfileRights

Gets the detailed rights configured by a security profile

<br />

```dart
Future<List<dynamic>> getProfileRights(String id)
```
<br />

| Property | Type | Description |
| --- | --- | --- |
| `id` | <pre>String</pre> | Profile identifier |

## Return

A List of objects. Each object is a security right described by the security profile:

- `controller`: impacted controller
- `action`: impacted controller action
- `index`: index name
- `collection`: collection name
- `value`: tells if access if `allowed` or `denied`. If closures have been configured on the detailed scope, the value is `conditional`.

## Usage

<<< ./snippets/get-profile-rights.dart
