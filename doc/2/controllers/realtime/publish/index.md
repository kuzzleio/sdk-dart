---
code: true
type: page
title: publish
description: Publishes a real-time message.
---

# publish

Sends a real-time message to Kuzzle. The message will be broadcasted to all clients with subscriptions matching the index, the collection and the message content.

The index and collection are indicative and serve only to distinguish the rooms. They are not required to exist in the database.

**Note:** real-time messages are not persisted in the database.

## Arguments

```dart
Future<bool> publish(
      String index, String collection, Map<String, dynamic> message)
```

| Argument     | Type               | Description                         |
|--------------|--------------------|-------------------------------------|
| `index`      | <pre>String</pre>  | Index name                          |
| `collection` | <pre>String</pre>  | Collection name                     |
| `message`    | <pre>Map<String, dynamic></pre> | Map representing a JSON payload |

## Usage

<<< ./snippets/publish.dart
