---
code: true
type: page
title: Constructor 
description: Creates a new Kuzzle object connected to the backend
order: 100
---

# Constructor

Use this constructor to create a new instance of the SDK.
Each instance represents a different connection to a Kuzzle server with specific options.

## Arguments

```dart
Kuzzle(
    protocol, {
    autoQueue = false,
    autoReplay = false,
    autoResubscribe = true,
    eventTimeout = 200,
    offlineMode = OfflineMode.manual,
    offlineQueueLoader,
    queueFilter,
    queueTTL,
    queueMaxSize = 500,
    replayInterval,
    globalVolatile,
  })
```

<br/>

| Argument   | Type                | Description                       |
| ---------- | ------------------- | --------------------------------- |
| `protocol` | <pre>AbstractProtocol</pre> | Protocol used by the SDK instance |

## protocol

The protocol used to connect to the Kuzzle instance.
It can be one of the following available protocols:

- [WebSocket](/sdk/dart/2/protocols/websocket)

## Return

The `Kuzzle` SDK instance.

## Usage

<<< ./snippets/constructor.dart
