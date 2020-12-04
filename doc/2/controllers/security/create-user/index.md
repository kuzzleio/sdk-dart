---
code: true
type: page
title: createUser
description: Creates a new user
---

# createUser

Creates a new user.

<br />

```dart
Future<KuzzleUser> createUser(String id, 
      Map<String, dynamic> body,
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `id` | <pre>String</pre> | User [id](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `body` | <pre>Map<String, dynamic></pre> | User content &amp; credentials |
| `waitForRefresh` | <pre>boolean</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the created user is indexed |

::: info
If the `kuid` is `null`, Kuzzle will generate an ID.
:::

### body

The `body` property must contain two objects:
- `content`: Contains the list of profile ids to attach the user to and potential additional information. At least the `profileIds` must be supplied.
Any other attribute can be added. 
Make sure to [update the user mapping](/sdk/dart/2/controllers/security/update-user-mapping) collection to match your custom attributes.
- `credentials`: Describes how the new administrator can be authenticated. This object must contain one or more 
properties, named after the target authentication strategy to use. Each one of these properties are objects
containing the credentials information, corresponding to that authentication strategy.

Example: 

```dart
{
  'content': {
    'profileIds': [
      'default'
    ],
    'firstName': 'John',
    'lastName': 'Doe'
  },
  'credentials': {
    'local': {
      'username': 'admin',
      'password': 'myPassword'
    }
  }
}
```

## Resolves

A [`User`](sdk/dart/2/core-classes/user/introduction) object containing information about the newly created user.

## Usage

<<< ./snippets/create-user.dart
