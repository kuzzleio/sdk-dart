---
code: true
type: page
title: connect
description: Connects the SDK to Kuzzle
---

# connect

Connects to Kuzzle using the underlying protocol `connect` method. 

Subsequent calls have no effect if the SDK is already connected.

## Arguments

```dart
Future<void> connect()
```

## Usage

<<< ./snippets/connect.dart
