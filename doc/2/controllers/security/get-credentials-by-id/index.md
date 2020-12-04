---
code: true
type: page
title: getCredentialsById
description: Gets credential information for the user identified by the strategy's unique user identifier userId.
---

# getCredentialsById

Gets credential information for the user identified by the strategy's unique user identifier `userId`.

The returned object will vary depending on the strategy (see [getById plugin function](/core/2/guides/write-plugins/integrate-authentication-strategy#optional-getbyid)), and can be empty.

**Note**: the user identifier to use depends on the specified strategy. 
If you wish to get credential information using a [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid) identifier, use the [getCredentials](sdk/dart/2/controllers/security/get-credentials) action instead.

<br />

```dart
Future<Map<String, dynamic>> getCredentialsById(
      String strategy, String id)
```

<br />

| Property | Type | Description |
| --- | --- | --- |
| `strategy` | <pre>String</pre> | Strategy identifier |
| `id` | <pre>String</pre> | Credential identifier (this is **not** the [kuid](/core/2/guides/main-concepts/authentication#kuzzle-user-identifier-kuid)) |

## Return

A Map containing the credential information (depends on the authentication strategy).

## Usage

<<< ./snippets/get-credentials-by-id.dart
