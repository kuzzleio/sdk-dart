import 'package:test/test.dart';
import 'package:kuzzle_dart/kuzzle_dart.dart';

import 'test_helpers.dart';

void main() {
  final KuzzleTestHelper kuzzleTestHelper = KuzzleTestHelper();
  setUpAll(() async {
    await kuzzleTestHelper.connect();
  });

  group('document', () {
    Collection collection;
    Document document;
    setUpAll(() async {
      await kuzzleTestHelper.kuzzle
          .createIndex(kuzzleTestHelper.kuzzle.defaultIndex);
      collection = kuzzleTestHelper.kuzzle.collection('posts');
      await collection.create();
    });

    test('count', () async {
      final int count = await collection.count();
      expect(count, 0);
    });

    test('create', () async {
      document = await collection.createDocument(<String, dynamic>{
        'title': 'This is a test post',
      });
      expect(document.content, <String, dynamic>{
        'title': 'This is a test post',
      });
      expect(await collection.count(), equals(1));
    });

    test('get', () async {
      final Document doc = await collection.fetchDocument(document.id);
      expect(doc.toMap(), document.toMap());
    });

    test('delete', () async {
      final String documentId = await document.delete();
      expect(documentId, document.id);
      expect(await collection.count(), equals(0));
    });

    test('scroll documents', () async {
      final ScrollResponse<Document> scrollDocument =
          await collection.scroll('1');
      expect(scrollDocument.hits.length, 0);
    });

    tearDownAll(() async {
      await kuzzleTestHelper.kuzzle
          .deleteIndex(kuzzleTestHelper.kuzzle.defaultIndex);
    });
  });

  tearDownAll(() {
    kuzzleTestHelper.end();
  });
}