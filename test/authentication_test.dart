import 'package:uuid/uuid.dart';
import 'package:test/test.dart';
import 'package:kuzzle/kuzzle.dart';

import 'helpers/kuzzle.dart';

void main() {
  final kuzzle = Kuzzle(WebSocketProtocol(Uri(
    scheme: 'ws',
    host: 'localhost',
    port: 7512,
  )));
  Map<String, dynamic> credentials;
  KuzzleUser user;
  setUpAll(() async {
    await connectKuzzle(kuzzle);
    final uuid = Uuid();
    credentials = {
      'username': uuid.v1(),
      'password': uuid.v1(),
    };
    user = KuzzleUser(kuzzle, content: {
      'name': 'Test User',
      'profileIds': <String>['default'],
    });
  });

  group('authentication', () {
    group('user auth', () {
      test('register', () async {
        final saveduser = await kuzzle.security
            .createUser(
              'user',
              {
                'credentials': {
                  'local': credentials
                },
                'content': user.content
              });
        expect(saveduser.content['name'], user.content['name']);
        user = saveduser;
      });

      test('login', () async {
        final response = await kuzzle.auth.login('local', credentials);
        expect(response.length, greaterThan(10));
      });

      test('check token', () async {
        final checkToken = await kuzzle.auth.checkToken(kuzzle.jwt);
        expect(checkToken['valid'], true);
        final prevToken = kuzzle.jwt;
        await kuzzle.auth.logout();
        final newCheckToken = await kuzzle.auth.checkToken(prevToken);
        expect(newCheckToken['valid'], false);
        expect((await kuzzle.auth.login('local', credentials)).length,
            greaterThan(10));
      });

      test('check if credentials exists', () async {
        expect(await kuzzle.auth.credentialsExist('local'), true);
      });

      test('delete credentials', () async {
        expect((await kuzzle.auth.deleteMyCredentials('local'))['acknowledged'],
            true);
      });

      test('create credentials', () async {
        final credentialsResponse =
            await kuzzle.auth.createMyCredentials('local', credentials);
        expect(credentialsResponse['username'], credentials['username']);
      });

      test('get credentials', () async {
        final currentUser = await kuzzle.auth.getMyCredentials('local');
        expect(currentUser['username'], credentials['username']);
        expect(currentUser['kuid'], user.uid);
      });

      test('update credentials', () async {
        final credentialsResponse =
            await kuzzle.auth.updateMyCredentials('local', credentials);
        expect(credentialsResponse['username'], credentials['username']);
      });

      test('get all strategies', () async {
        expect(await kuzzle.auth.getStrategies(), ['local']);
      });

      test('get current user', () async {
        final currentUser = await kuzzle.auth.getCurrentUser();
        expect(currentUser.uid, user.uid);
        expect(currentUser.profileIds, ['default']);
        expect(currentUser.content['name'], user.content['name']);
      });

      test('update self', () async {
        final content = {'lastname': 'Some last name'};
        final updatedUser = await kuzzle.auth.updateSelf(content);
        expect(updatedUser.uid, user.uid);
        expect(updatedUser.content['name'], user.content['name']);
        expect(updatedUser.content['lastname'], 'Some last name');
      });

      test('whoami', () async {
        final iAm = await kuzzle.auth.getCurrentUser();
        expect(iAm.uid, user.uid);
      });

      test('get my rights', () async {
        final rights = await kuzzle.auth.getMyRights();
        // All rights are valid
        expect(rights.length, 1);
        expect(rights[0]['controller'], '*');
        expect(rights[0]['action'], '*');
        expect(rights[0]['index'], '*');
        expect(rights[0]['collection'], '*');
        expect(rights[0]['value'], 'allowed');
      });

      test('signout', () async {
        await kuzzle.auth.logout();
      });

      test('search users', () async {
        final searchUsers = await kuzzle.security.searchUsers(query: {
          'query': {
            'bool': {
              'must': [
                {
                  'terms': {
                    'profileIds': ['anonymous', 'default']
                  }
                }
              ]
            }
          }
        });
        expect(searchUsers.total, 1);
        expect(searchUsers.hits[0].uid, user.uid);
      });
    });
    test('roles crud', () {});
    test('profiles crud', () {});
    test('login/logout', () {});

    tearDownAll(() async {
      await kuzzle.security.deleteUser(user.uid);
    });
  });

  tearDownAll(kuzzle.disconnect);
}
