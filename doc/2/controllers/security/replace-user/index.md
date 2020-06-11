---
code: true
type: page
title: replaceUser
description: Replaces a user with new configuration.
---

# replaceUser

Replaces a user with new configuration.

<br />

```dart
Future<KuzzleUser> replaceUser(String uid, 
  Map<String, dynamic> body, {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `kuid` | <pre>String</pre> | User [kuid](/core/2/guides/essentials/user-authentication#kuzzle-user-identifier-kuid) |
| `body` | <pre>Map<String, dynamic></pre> | User content |
| `waitForRefresh` | <pre>boolean</pre><br />(`false`) | If set to `true`, Kuzzle will not respond until the created user is indexed |

### body

**mandatory properties**

| Property | Type | Description |
| --- | --- | --- |
| `profileIds` | <pre>List<String></pre> | Profile identifiers to assign the user to |

**other properties**

The body can be extended with any custom information. 
Make sure to [update the user mapping](/sdk/dart/2/controllers/security/update-user-mapping) collection to match your custom attributes.

example:

```dart
{
  'profileIds': [ 'default' ],
  'firstName': 'John',
  'lastName': 'Doe'
}
```

## Return

An [`User`](sdk/dart/2/core-classes/user/introduction) object containing information about the updated user.

## Usage

<<< ./snippets/replace-user.dart