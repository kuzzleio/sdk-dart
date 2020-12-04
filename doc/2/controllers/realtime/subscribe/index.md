---
code: true
type: page
title: subscribe
description: Subscribes to real-time notifications.
---

# Subscribe

Subscribes by providing a set of filters: messages, document changes and, optionally, user events matching the provided filters will generate [real-time notifications](/core/2/api/payloads/notifications), sent to you in real-time by Kuzzle.

## Arguments

```dart
Future<String> subscribe(String index, String collection,
      Map<String, dynamic> filters, SubscribeListener callback,
      {String scope,
      String state,
      String users,
      Map<String, dynamic> volatile,
      bool subscribeToSelf,
      bool autoResubscribe})
```

| Argument     | Type                                    | Description                                         |
|--------------|-----------------------------------------|----------------------------------------------------------------------------------------------------------------|
| `index`      | <pre>String</pre>                       | Index name                                            |
| `collection` | <pre>String</pre>                      | Collection name                                       |
| `filters`    | <pre>Map<String, dynamic></pre>        | Map representing a set of filters following [Koncorde syntax](/core/2/api/koncorde-filters-syntax) |
| `callback`   | <pre>SubscribeListener</pre>          | Handler function to handle notifications                    |
| `scope`           | <pre>String</pre><br/>(`all`)   | Subscribes to document entering or leaving the scope<br/>Possible values: `all`, `in`, `out`, `none`| yes |
| `users`           | <pre>Users</pre><br/>(`none`)  | Subscribes to users entering or leaving the room<br/>Possible values: `all`, `in`, `out`, `none`| yes |
| `subscribeToSelf` | <pre>boolean</pre><br/>(`true`)    | Subscribes to notifications fired by our own queries |
| `autoResubscribe` | <pre>boolean</pre><br/>(`false`)    | Automatically resubscribe after connection loss |
| `volatile`        | <pre>Map<String, dynamic></pre><br/>(`null`) | ConcurrentHashMap representing subscription information, used in [user join/leave notifications](/core/2/guides/main-concepts/api#volatile-data)  |

### handler

Handler function that will be called each time a new notification is received.
The hanlder will receive a [KuzzleResponse](/sdk/dart/2/essentials/realtime-notifications) as its only argument.

## Return

The room ID.

## Usage

_Simple subscription to document notifications_

<<< ./snippets/document-notifications.dart

_Subscription to document notifications with scope option_

<<< ./snippets/document-notifications-leave-scope.dart
