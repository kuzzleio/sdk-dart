import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
import 'package:kuzzle/kuzzle.dart';

import 'helpers/kuzzle.dart';

void main() {
  final kuzzle = Kuzzle(WebSocketProtocol(Uri(
    scheme: 'ws',
    host: 'localhost',
    port: 7512,
  )));
  String defaultIndex;
  String defaultCollection;

  setUpAll(() async {
    await connectKuzzle(kuzzle);
    // await kuzzle.auth.login('local', adminCredentials);
    defaultIndex = Uuid().v1();
    defaultCollection = 'posts';
  });

  reCreate() async {
    final response = await kuzzle.collection.create(
      defaultIndex,
      defaultCollection,
      mapping: {'title': {}},
    );
  }

  group('collection', () {
    setUpAll(() async {
      await kuzzle.index.create(defaultIndex);
    });
    test('creation', () async {
      final response = await kuzzle.collection.create(
        defaultIndex,
        defaultCollection,
        mapping: {'title': {}},
      );
      expect(response['acknowledged'], true);
    });

    test('delete specification', () async {
      final response = await kuzzle.collection.deleteSpecifications(
        defaultIndex,
        defaultCollection,
      );
      expect(response['acknowledged'], true);
    });

    test('exists', () async {
      final response = await kuzzle.collection.exists(
        defaultIndex,
        defaultCollection,
      );
      expect(response, true);
    });

    test('get mapping', () async {
      final response = await kuzzle.collection.getMapping(
        defaultIndex,
        defaultCollection,
      );
      expect(response, <String, dynamic>{
        'dynamic': 'false',
        'properties': {},
      });
    });

    test('list all collections', () async {
      final response = await kuzzle.collection.list(defaultIndex);
      print(response);
      expect(
        response['collections'].length,
        greaterThanOrEqualTo(1),
      );
      expect(
        response['collections'][0]['name'],
        defaultCollection,
      );
    });

    test('refresh', () async {
      final response = await kuzzle.collection.refresh(
        defaultIndex,
        defaultCollection,
      );

      expect(response, true);
    });

    test('search specifications', () async {
      final response = await kuzzle.collection.searchSpecifications(
        defaultIndex,
      );
      expect(response.hits.length, greaterThanOrEqualTo(0));
    });

    test('truncate', () async {
      final response = await kuzzle.collection.truncate(
        defaultIndex,
        defaultCollection,
      );
      expect(response.length, 1);
    });

    test('update specifications', () async {
      final response = await kuzzle.collection.updateSpecifications(
        defaultIndex,
        defaultCollection,
        {
          'fields': {
            'title': {
              'mandatory': false,
              'type': 'string'
            },
          },
        },
      );
      expect(response, <String, dynamic>{
        'fields': {
          'title': {
            'mandatory': false,
            'type': 'string',
          },
        },
      });
    });

    test('get specifications', () async {
      final response = await kuzzle.collection.getSpecifications(
        defaultIndex,
        defaultCollection,
      );
      var hasAllKeys = false;

      for (var key in ['collection', 'index', 'validation', '_kuzzle_info']) {
        hasAllKeys = response.containsKey(key);

        if (!hasAllKeys) {
          break;
        }
      }

      expect(hasAllKeys, true);
      expect(response['index'], defaultIndex);
      expect(response['collection'], defaultCollection);
      expect(response['validation'].runtimeType, <String, dynamic>{}.runtimeType);
    });
    test('validate specifications', () async {
      final response = await kuzzle.collection.validateSpecifications(
        defaultIndex,
        defaultCollection,
        {},
      );
      expect(response, true);
    });

    tearDownAll(() async {
      await kuzzle.index.delete(defaultIndex);
    });
  });

  tearDownAll(kuzzle.disconnect);
}
