---
code: true
type: page
title: Connect
description: Connects the SDK to Kuzzle
---

# Connect

Connects to Kuzzle using the underlying protocol `connect` method. 

Subsequent calls have no effect if the SDK is already connected.

## Arguments

```dart
Future<void> connect()
```

## Usage

<<< ./snippets/connect.dart
