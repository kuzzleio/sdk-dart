---
code: true
type: page
title: constructor
description: Creates a new Http protocol
order: 50
---

# Constructor

Use this constructor to create a new instance of the `Http` protocol with specific Uri Dart Object [https://api.dart.dev/stable/2.10.5/dart-core/Uri-class.html](https://api.dart.dev/stable/2.10.5/dart-core/Uri-class.html)

## Arguments

```dart
HttpProtocol(Uri);
```

<br/>

| Argument  | Type              | Description                  |
| --------- | ----------------- | ---------------------------- |
| `uri`    | <pre>Uri</pre> | URI pointing to a Kuzzle server. See more: [https://api.dart.dev/stable/2.10.5/dart-core/Uri-class.html](https://api.dart.dev/stable/2.10.5/dart-core/Uri-class.html) |


## Return

A `HttpProtocol` protocol instance.

## Usage

<<< ./snippets/constructor.dart
