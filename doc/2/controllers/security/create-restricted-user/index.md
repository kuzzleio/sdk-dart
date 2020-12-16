---
code: true
type: page
title: createRestrictedUser
description: Creates a new user in Kuzzle, with a preset list of security profiles.
---

# createRestrictedUser

Creates a new user in Kuzzle, with a preset list of security profiles.

The list of security profiles attributed to restricted users is fixed, and must be configured in the 
[Kuzzle configuration file](/core/2/guides/advanced/configuration).

This method allows users with limited rights to create other accounts, but blocks them from creating accounts with unwanted privileges (e.g. an anonymous user creating his own account).

<br />

```dart
Future<KuzzleUser> createRestrictedUser(Map<String, dynamic> body, String uid,
      {bool waitForRefresh})
```

<br />

| Property | Type | Description |
|--- |--- |--- |
| `body` | <pre>Map<String, dynamic></pre> | User content &amp; credentials |
| `kuid` | <pre>String</pre> | User [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid). If not provided, a random kuid is automatically generated |
| `waitForRefresh` | <pre>boolean</pre><br />(`null`) | If set to `true`, Kuzzle will not respond until the user is indexed |


### body

The `body` property must contain two objects:
- `content`: User additional information. Can be left empty.
- `credentials`: Describe how the new user can be authenticated. This object must contain one or more 
properties, named after the target authentication strategy to use. Each one of these properties are objects
containing the credentials information, corresponding to that authentication strategy.

Example: 

```dart
{
  'content': {
    'firstName': 'John',
    'lastName': 'Doe'
  },
  'credentials': {
    'local': {
      'username': 'jdoe',
      'password': 'password'
    }
  }
}
```

## Resolves

A [`User`](sdk/js/6/core-classes/user/introduction) object containing information about the newly created user.

## Usage

<<< ./snippets/create-restricted-user.dart
