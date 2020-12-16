---
code: true
type: page
title: updateUser
description: Updates a user definition.
---

# updateUser

Updates a user definition.

<br />

```dart
Future<KuzzleUser> updateUser(String id, Map<String, dynamic> body,
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | User [id](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `body` | <pre>Map<String, dynamic></pre> | User content |
| `waitForRefresh` | <pre>bool</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the updated user is indexed |

### body

The `body` contains the list of profile ids to attach the user to and potential additional information.  
Any other attribute can be added. 
Make sure to [update the user mapping](/sdk/dart/2/controllers/security/update-user-mapping) collection to match your custom attributes.

Example: 

```dart
{
  'profileIds': [
    'default'
  ],
  'firstName': 'John',
  'lastName': 'Doe'
}
```

## Return

A [`User`](sdk/dart/2/core-classes/user/introduction) object containing information about the updated user.

## Usage

<<< ./snippets/update-user.dart
