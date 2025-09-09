import 'package:meta/meta.dart';

class _KuzzleListener {
  _KuzzleListener(this.fn, {this.once});

  final Function fn;
  final bool? once;
}

class KuzzleEventEmitter {
  KuzzleEventEmitter();

  final Map<String, List<_KuzzleListener>> _events = {};

  bool _exist(String eventName, Function callback) {
    assert(eventName.isNotEmpty);

    if (!_events.containsKey(eventName)) {
      return false;
    }

    return _events[eventName]!
        .where((listener) => listener.fn == callback)
        .isNotEmpty;
  }

  List<String> eventNames() => _events.keys.toList();

  int listenerCount(String eventName) {
    assert(eventName.isNotEmpty);

    return listeners(eventName)!.length;
  }

  List<_KuzzleListener>? listeners(String eventName) {
    assert(eventName.isNotEmpty);

    if (!_events.containsKey(eventName)) {
      return <_KuzzleListener>[];
    }

    return _events[eventName];
  }

  @mustCallSuper
  void addListener(String eventName, Function callback, {bool once = false}) {
    assert(eventName.isNotEmpty);

    if (!_events.containsKey(eventName)) {
      _events[eventName] = <_KuzzleListener>[];
    }

    if (!_exist(eventName, callback)) {
      _events[eventName]!.add(_KuzzleListener(callback, once: once));
    }
  }

  @mustCallSuper
  void prependListener(String eventName, Function callback,
      {bool once = false}) {
    assert(eventName.isNotEmpty);

    if (!_events.containsKey(eventName)) {
      _events[eventName] = <_KuzzleListener>[];
    }

    if (!_exist(eventName, callback)) {
      _events[eventName]!.insert(0, _KuzzleListener(callback, once: once));
    }
  }

  @mustCallSuper
  void removeListener(String eventName, Function callback) {
    assert(eventName.isNotEmpty);

    if (!_events.containsKey(eventName)) {
      return;
    }

    _events[eventName]!.removeWhere((listener) => listener.fn == callback);

    if (_events[eventName]!.isEmpty) {
      _events.remove(eventName);
    }
  }

  @mustCallSuper
  void removeAllListeners([String? eventName]) {
    if (eventName != null && eventName.isNotEmpty) {
      _events[eventName]!.clear();
    } else {
      _events.clear();
    }
  }

  void on(String eventName, Function callback) =>
      addListener(eventName, callback);

  void off(String eventName, Function callback) =>
      removeListener(eventName, callback);

  void once(String eventName, Function callback) =>
      addListener(eventName, callback, once: true);

  /// Call all listeners registered for [eventName] event
  ///
  /// All listeners found are called with [positionalArguments]
  /// and [namedArguments]
  ///
  /// Listeners registered as once is then cleared
  @mustCallSuper
  bool emit(
    String eventName, [
    List? positionalArguments,
    Map<Symbol, dynamic>? namedArguments,
  ]) {
    assert(eventName.isNotEmpty);

    if (!_events.containsKey(eventName)) {
      return false;
    }

    final _listeners = listeners(eventName)!;
    final _onceListeners = <_KuzzleListener>[];

    for (final listener in _listeners) {
      if (listener.once!) {
        _onceListeners.add(listener);
      }

      try {
        Function.apply(listener.fn, positionalArguments, namedArguments);
      } on Exception {
        print('$runtimeType.emit($eventName) => listener.fn errored');
        print('Did the listener was registered correctly?');
      }
    }

    for (final listener in _onceListeners) {
      removeListener(eventName, listener.fn);
    }

    return true;
  }
}
