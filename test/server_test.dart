import 'package:test/test.dart';
import 'package:kuzzle/kuzzle.dart';

import 'helpers/kuzzle.dart';

void main() {
  final kuzzle = Kuzzle(WebSocketProtocol(Uri(
    scheme: 'ws',
    host: 'localhost',
    port: 7512,
  )));
  var isConnectedEventCalled = false;

  setUpAll(() async {
    kuzzle.on('connected', () {
      isConnectedEventCalled = true;
    });
    await connectKuzzle(kuzzle);
  });

  test('check admin', () async {
    expect(await kuzzle.server.adminExists(), true);
  });

  test('check ConnectedEvent called', () {
    expect(isConnectedEventCalled, true);
  });

  test('get all statistics', () async {
    final stats = await kuzzle.server.getAllStats();
    expect(stats['total'], greaterThanOrEqualTo(1));
  });

  test('last staticstics', () async {
    final stat = await kuzzle.server.getLastStats();
    expect(stat['timestamp'], lessThan(DateTime.now().millisecondsSinceEpoch));
  });

  test('get config', () async {
    final config = await kuzzle.server.getConfig();
    expect(config['services']['internalCache']['backend'], 'redis');
  });

  test('get server info', () async {
    final info = await kuzzle.server.info();
    expect(info['serverInfo'].containsKey('kuzzle'), true);
  }); //, skip: 'Have to check the response'

  test('get current time', () async {
    final now = await kuzzle.server.now();
    expect(now.difference(DateTime.now()).inMilliseconds, lessThanOrEqualTo(0));
  });

  tearDownAll(kuzzle.disconnect);
}
