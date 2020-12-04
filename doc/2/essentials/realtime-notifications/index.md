---
code: false
type: page
title: Realtime notifications
description: List of realtime notifications sent by Kuzzle
order: 300
---

# Notifications

The [RealtimeController.subscribe](/sdk/dart/2/controllers/realtime/subscribe) method takes a handler argument, called with a [KuzzleResponse](/sdk/dart/2/core-classes/response) object, whose content of the `Result` property depends on the type of notification received.

## Document & messages

These notifications represent [documents changes & messages](/core/2/api/payloads/notifications#document-notification).

The `Result` Map is the notification content, and it has the following structure:

| Property  | Type              | Description                                                                             |
| --------- | ----------------- | --------------------------------------------------------------------------------------- |
| `_id`     | <pre>String</pre> | Document unique ID<br/>`null` if the notification is from a real-time message             |
| `_source` | <pre>Map<String, dynamic></pre> | Message or full document content. Not present if the event is about a document deletion |

## User

These notifications represent [user events](/core/2/api/payloads/notifications#user-notification).

The `Result` object is the notification content, and it has the following structure:

| Property | Type              | Description                                        |
| -------- | ----------------- | -------------------------------------------------- |
| `count`  | <pre>int</pre> | Updated users count sharing that same subscription |
