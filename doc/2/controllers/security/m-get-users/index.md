---
code: true
type: page
title: mGetUsers
description: Gets multiple security users
---

# mGetUsers

Gets multiple security users.

<br />

```dart
Future<List<KuzzleUser>> mGetUsers(List<String> ids)
```


| Property | Type | Description |
|--- |--- |--- |
| `ids` | `List<String>` | User identifiers |
| `verb`| <pre>String</pre> | (HTTP only) Forces the verb of the API route |

#### verb

When instantiated with a HTTP protocol object, the SDK uses the GET API by default for this API route.
You can set the `verb` option to `POST` to force the SDK to use the POST API instead.

## Returns

An array of retrieved [`User`](/sdk/dart/2/core-classes/user/introduction) objects.

## Usage

<<< ./snippets/m-get-users.dart
