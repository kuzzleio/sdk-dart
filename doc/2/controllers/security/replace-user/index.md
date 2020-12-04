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
Future<KuzzleUser> replaceUser(String id, 
  Map<String, dynamic> body, {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | User [id](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `body` | <pre>Map<String, dynamic></pre> | User content |
| `waitForRefresh` | <pre>boolean</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the created user is indexed |

### body

**mandatory properties**

| Property | Type | Description |
| --- | --- | --- |
| `profileIds` | `List<String>` | Profile identifiers to assign the user to |

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
