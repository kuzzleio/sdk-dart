---
type: page
code: false
title: Flutter
description: Getting started with Kuzzle and Flutter
order: 0
---

# Getting Started with Kuzzle and Flutter

This section deals with **Kuzzle v2**, the **Dart SDK v2** and **Flutter**. We will create **documents** in Kuzzle and subscribe to [document notifications](/sdk/dart/2/essentials/realtime-notifications#document-messages) to develop a realtime chat.

## Requirements

- **Running Kuzzle v2 Stack** ([instructions here](/core/2/guides/getting-started/run-kuzzle))
- **Setup an editor** ([instructions here](https://flutter.dev/docs/get-started/editor))
- **Create a new project** ([instructions here](https://flutter.dev/docs/get-started/test-drive?tab=androidstudio#create-app))

## Use the Kuzzle SDK in your flutter app

You can find the kuzzle package on pub.dev. ([https://pub.dev/packages/kuzzle](https://pub.dev/packages/kuzzle))

The `pubspec.yaml` file manages the assets and dependencies for a Flutter app. In `pubspec.yaml`, add kuzzle (2.0.1 or higher) to the dependencies list:

```yaml
dependencies:
  flutter:
    sdk: flutter
  kuzzle: ^2.0.1
```

Then run `flutter pub get` to install the new dependency

```bash
$ flutter pub get
```

## App entry point

Let's start with the main:

_main.dart:_

<<< ./snippets/main.dart.snippet[dart]

## Set a username

Here we will ask the user to enter its username.
To keep it simple, this does not use the authentication system of Kuzzle but feel free to implement it for a better usage.

_login.dart:_

<<< ./snippets/login.dart.snippet[dart]

## The chat

We have to connect the server so that our client can interact with it (note that the host is the API of an android emulator in this example).

In our _chat.dart_ let's import the sdk:

<<< ./snippets/chat.dart.snippet:1[dart]

Then we will [establish the connection](/sdk/dart/2/core-classes/kuzzle/connect) to kuzzle and create, if they don't [exist](/sdk/dart/2/controllers/index/exists/), the [index](/sdk/dart/2/controllers/index/create) and [collection](/sdk/dart/2/controllers/collection/create) of our chat. We will also fetch messages sorted by creation date, and  subscribe to the same collection to receive new messages in realtime.

### Create index and collection

So first let's write a method which will create the index/collection if it does not exist:

<<< ./snippets/chat.dart.snippet:2[dart]


### Get existing messages

The method _fetchMessage()_ will [search](/sdk/dart/2/controllers/document/search) for the first hundred newest messages.
It will then update the state of the widget to store those messages in the `messages` variable.

<<< ./snippets/chat.dart.snippet:3[dart]

### Receive new messages in realtime

And finally the method to subscribe to our collection.
It will call the Kuzzle's realtime controller to allow us to receive [real-time notifications](/core/2/api/payloads/notifications) on message creations. New messages received that way will then be added to our list of previously fetched `messages`, and rendered in our list, by updating the state.

<<< ./snippets/chat.dart.snippet:4[dart]

### Call previous written methods

Then we are going to call all of those methods in the `initState` method of the State of our `StatefulWidget`:

<<< ./snippets/chat.dart.snippet:5[dart]

As you can see we use a model to retrieve each message from the JSON Response to a Dart class.

Here:

<<< ./snippets/chat.dart.snippet:6[dart]

And here:

<<< ./snippets/chat.dart.snippet:7[dart]

So here is the Dart class used for this model

_message.dart:_

<<< ./snippets/message.dart.snippet[dart]

### Display everything

Finally let's make a view to display everything and add an input to be able to send a message in our `build()` method:

_chat.dart:_

<<< ./snippets/chat.dart.snippet:8[dart]

And _chat_view.dart:_

<<< ./snippets/chat_view.dart.snippet[dart]

### Sending messages

Finally let's see how to send a new message using the Kuzzle sdk:

_chat.dart:_

<<< ./snippets/chat.dart.snippet:9[dart]

For this we simply [create](/sdk/dart/2/controllers/document/create) a document in our `messages` collection with a `username` and a `value`. Once this document is created it will trigger a notification to all clients who subscribed to this collection and receive the message.

## Where do we go from here?

Now that you're more familiar with Kuzzle, dive even deeper to learn how to leverage its full capabilities:

- discover what this SDK has to offer by browsing other sections of this documentation
- learn more about Kuzzle [realtime engine](/core/2/guides/main-concepts/realtime-engine)
- follow our guide to learn how to [manage users, and how to set up fine-grained access control](/core/2/guides/main-concepts/permissions)
- lean how to use Kuzzle [Admin Console](http://next-console.kuzzle.io) to manage your users and data
- learn how to perform a [basic authentication](/sdk/dart/2/controllers/auth/login)
