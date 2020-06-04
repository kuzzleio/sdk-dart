---
code: false
type: page
title: Properties
description: Profile Properties
order: 10
---

# Properties

| Property | Type | Description |
|--- |--- |--- |
| `_id` | <pre>String</pre> | Profile ID |
| `policies` | <pre>List<dynamic></pre> | List of policies for this profile |

### policies

Each policy object can contain the following properties:

| Property | Type | Description |
|--- |--- |--- |
| `roleId` | <pre>String</pre> | Roles IDs for this user |
| `restrictedTo` | <pre>List<dynamic></pre> | List containing indexes and collections which the profile is restricted to |
