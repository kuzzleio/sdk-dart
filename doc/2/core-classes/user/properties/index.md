---
code: false
type: page
title: Properties
description: User class properties
order: 10
---

# Properties


| Property | Type | Description |
|--- |--- |--- |
| `_id` | <pre>String</pre> | User ID (kuid) |
| `content` | <pre>Map<String, dynamic></pre> | User internal content |

### content

The `content` property is a Map containing, alongside custom defined values, the following generic properties:

| Property | Type | Description |
|--- |--- |--- |
| `profileIds` | `List<String>` | Profiles IDs for this user |
| `_kuzzle_info` | <pre>Map<String, dynamic></pre> | [Kuzzle metadata](/core/2/guides/main-concepts/data-storage#kuzzle-metadata) |
