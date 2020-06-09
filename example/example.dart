import 'package:kuzzle/kuzzle.dart';

void main() {
  final kuzzle = Kuzzle(
    WebSocketProtocol('127.0.0.1'),
    offlineMode: OfflineMode.auto,
  );

  // connection events
  kuzzle.on('connected', () => print('[connected]'));
  kuzzle.on('disconnected', () => print('[disconnected]'));
  kuzzle.on('reconnected', () => print('[reconnected]'));

  // errors events
  kuzzle.on('discarded', (request) => print('[discarded] => $request'));
  kuzzle.on('queryError', (error, request) {
    print('[queryError] => $request');
    print(error);
  });
  kuzzle.on('networkError', (error) {
    print('[networkError]');
    print(error);
  });

  // login
  kuzzle.on('loginAttempt', ({success, error}) {
    print('[loginAttempt] success: $success');
    print(error);
  });

  // offline queue events
  kuzzle.on('offlineQueuePush', (request) => print('[queue] => $request'));
  kuzzle.on('offlineQueuePop', (request) => print('[dequeue] => $request'));

  // perform a query when offline
  kuzzle
      .query(KuzzleRequest(controller: 'server', action: 'now'))
      .catchError((error) {
    // should raise an error:
    // KuzzleError[Unable to execute request: not connected to a Kuzzle server.]
    assert(error is KuzzleError);
    print(error);
  });

  kuzzle.connect().then((_) async {
    // this query should not be queued and resolved when answered
    final now = await kuzzle.server.now();
    print('[result][server][now] $now');

    var user = await kuzzle.auth.getCurrentUser();
    print('[result][auth][getCurrentUser] 1 $user');

    final token = await kuzzle.auth.login('local', <String, dynamic>{
      'username': 'awesome',
      'password': 'p@ssw0rd',
    });
    print('[result][auth][login] $token');

    user = await kuzzle.auth.getCurrentUser();
    print('[result][auth][getCurrentUser] 2 $user');

    final results = await kuzzle.document
        .search('myindex', 'mycollection', query: <String, dynamic>{
      'query': <String, dynamic>{
        'match': <String, dynamic>{
          '_kuzzle_info.author': user.uid,
        }
      }
    });
    print(results.hits);

    final roomId = await kuzzle.realtime
        .subscribe('myindex', 'mycollection', <String, dynamic>{}, (response) {
      print('[subscription] $response');
    });
    print('subscribed to room $roomId');
  });

  // perform a query when connection status is not known
  kuzzle
      .query(KuzzleRequest(controller: 'server', action: 'now'))
      .then((response) {
    // this query should be queued and resolved when connected & answered
    assert(response is KuzzleResponse);

    print('[response][queued] $response');
  });
}
