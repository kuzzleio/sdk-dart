---
code: true
type: page
title: createFirstAdmin
description: Creates a Kuzzle administrator account, only if none exist.
---

# createFirstAdmin

Creates a Kuzzle administrator account, only if none exist.

<br />

```dart
Future<KuzzleUser> createFirstAdmin(
    String uid, Map<String, dynamic> body,
    {bool reset})
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `kuid` | <pre>String</pre> | Administrator [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) |
| `body` | <pre>Map<String, dynamic></pre> | Administrator content &amp; credentials |
| `reset` | <pre>bool</pre><br />(`null`) | If true, restricted permissions are applied to `anonymous` and `default` roles |

### body

The `body` property must contain two `Map<String, dynamic>`:
- `content`: Administrator additional information. Can be left empty.
Any other attribute can be added. 
Make sure to [update the user mapping](/sdk/dart/2/controllers/security/update-user-mapping) collection to match your custom attributes.
- `credentials`: Describe how the new administrator can be authenticated. This object must contain one or more 
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
      'username': 'admin',
      'password': 'myPassword'
    }
  }
}
```

## Return

A [`User`](sdk/dart/2/core-classes/user/introduction) object containing information about the newly created administrator.

## Usage

<<< ./snippets/create-first-admin.dart
