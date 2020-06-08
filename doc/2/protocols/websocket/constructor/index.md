---
code: true
type: page
title: Constructor
description: Creates a new WebSocket protocol
order: 50
---

# Constructor

Initializes a new instance of the WebSocket class pointing to the Kuzzle server specified by the uri.

## Arguments

```dart
WebSocketProtocol(
    Uri uri, {
    bool autoReconnect = true,
    Duration reconnectionDelay,
    Duration pingInterval,
  })
```

<br/>

| Argument  | Type              | Description                  |
| --------- | ----------------- | ---------------------------- |
| `uri`    | <pre>Uri</pre> | URI pointing to a Kuzzle server |
| `autoReconnect` | <pre>bool</pre> | If `true` will automatically reconnect after a conneciton loss |
| `port` | <pre>int</pre> | Kuzzle port |
| `reconnectionDelay` | <pre>Duration</pre> | Time to wait before trying to reconnect |
| `ssl` | <pre>bool</pre><br>(`false`) | If `true` will use SSL |
| `pingInterval` | <pre>Duration</pre> | Time to wait between each ping |

## Return

A `WebSocketProtocol` protocol instance.

## Usage

<<< ./snippets/constructor.dart
