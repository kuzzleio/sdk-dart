import 'dart:async';

import 'package:kuzzle/src/kuzzle/response.dart';
import 'package:kuzzle/src/protocols/events.dart';

import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import 'abstract.dart';

typedef SubscribeListener = void Function(KuzzleResponse);

class Subscription {
    Subscription({this.index,
                this.collection,
                this.filters,
                this.callback,
                this.autoResubscribe,
                this.subscribeToSelf,
                this.state,
                this.scope,
                this.users,
                this.volatile}
    );

    String index;
    String collection;
    Map<String, dynamic> filters;
    SubscribeListener callback;
    bool autoResubscribe;
    bool subscribeToSelf;
    String state;
    String scope;
    String users;
    Map<String, dynamic> volatile;
}

class RealTimeController extends KuzzleController {
  RealTimeController(Kuzzle kuzzle) : super(kuzzle, name: 'realtime') {
    kuzzle.protocol.on(ProtocolEvents.UNHANDLED_RESPONSE, 
    (KuzzleResponse message) {
      var fromSelf = false;
      if (message.volatile != null && message.volatile.isNotEmpty) {
        if (message.volatile.containsKey('sdkInstanceId') &&
            message.volatile['sdkInstanceId'] == kuzzle.protocol.id) {
          fromSelf = true;
        }
      }

      final subs = _currentSubscriptions[message.room];
      for (final sub in subs) {
        if (sub.subscribeToSelf == true || !fromSelf) {
          sub.callback(message);
        }
      }
    });
  }

  final Map<String, List<Subscription>> _currentSubscriptions = {};
  final Map<String, List<Subscription>> _subscriptionsCache = {};

  /// room => channel
  final Map<String, String> _rooms = {};

  /// Returns the number of other connections sharing the same subscription.
  Future<int> count(String roomId) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'count',
      body: <String, dynamic>{
        'roomId': roomId,
      },
    ));

    return response.result['count'] as int;
  }

  /// Sends a real-time message to Kuzzle.
  ///
  /// The message will be dispatched to all clients with
  /// subscriptions matching the index, the collection and the message content.
  ///
  /// A _kuzzle_info object will be added to the message content,
  /// with the following properties:
  ///  - author: sender kuid
  ///  (or -1 if the message is sent by an anonymous connection)
  ///  - createdAt: message timestamp, using the Epoch-millis format
  Future<bool> publish(
      String index, String collection, Map<String, dynamic> message) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'publish',
      index: index,
      collection: collection,
      body: message,
    ));

    return response.result['published'] as bool;
  }

  /// Subscribes by providing a set of filters: messages, document changes and,
  /// optionally, user events matching the provided filters will
  /// generate real-time notifications, sent to you in real-time by Kuzzle.
  Future<String> subscribe(String index, String collection,
      Map<String, dynamic> filters, SubscribeListener callback,
      {String scope = 'all',
      String state,
      String users,
      Map<String, dynamic> volatile,
      bool subscribeToSelf = true,
      bool autoResubscribe}) async => kuzzle.query(
        KuzzleRequest(
          action: 'subscribe',
          controller: 'realtime',
          index: index,
          collection: collection,
          body: filters,
          state: state,
          scope: scope,
          users: users,
          volatile: volatile,
        ),
        volatile: volatile)
        .then((response) {
          final subscription = Subscription(
            index: index, 
            collection: collection, 
            filters: filters, 
            callback: callback,
            volatile: volatile,
            users: users,
            scope: scope,
            state: state,
            subscribeToSelf: subscribeToSelf,
            autoResubscribe: autoResubscribe
          );
          final roomId = response.result['roomId'] as String;
          final channel = response.result['channel'] as String;

          if (_currentSubscriptions[channel] == null) {
            final List<Subscription> item = [];
            item.add(subscription);
            _currentSubscriptions[channel] = item;
            _subscriptionsCache[channel] = item;
          } else {
            if (!_currentSubscriptions[channel].contains(subscription)) {
              _currentSubscriptions[channel].add(subscription);
            }
            if (!_subscriptionsCache[channel].contains(subscription)) {
              _subscriptionsCache[channel].add(subscription);
            }
          }
          _rooms[roomId] = channel;

          kuzzle.on(ProtocolEvents.RECONNECTED, _renewSubscribe);

          return roomId;
        });

  void _renewSubscribe() async {
    for (final subs in _subscriptionsCache.values) {
      final List<Subscription> _localSubs = List<Subscription>.from(subs);
      subs.clear();
      for (final sub in _localSubs) {
        await subscribe(
          sub.index,
          sub.collection,
          sub.filters,
          sub.callback,
          scope: sub.scope,
          state: sub.state,
          users: sub.users,
          volatile: sub.volatile,
          subscribeToSelf: sub.subscribeToSelf,
          autoResubscribe: sub.autoResubscribe,
        );
      }
    }
  }

  /// Removes a subscription.
  Future<void> unsubscribe(String roomId) async {
    if (!_currentSubscriptions.containsKey(_rooms[roomId])) {
      return Future.error(
          KuzzleError(
            'not.subscribed',
            '$name.unsubscribe: not subscribed to $roomId'
          ));
    }

    await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'unsubscribe',
        body: <String, dynamic>{'roomId': roomId}));

    _currentSubscriptions[roomId]?.clear();
    _subscriptionsCache[roomId]?.clear();
    _rooms.remove(roomId);
  }
}
