import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import 'abstract.dart';

class BulkController extends KuzzleController {
  BulkController(Kuzzle kuzzle) : super(kuzzle, name: 'bulk');

  /// Creates, updates or deletes
  /// large amounts of [documents] as fast as possible.
  Future<Map<String, dynamic>> import(
      String index, 
      String collection, 
      List<Map<String, dynamic>> documents,
      {
        bool waitForRefresh = false,
      }) async {
    final response = await kuzzle.query(KuzzleRequest(
      action: 'import',
      collection: collection,
      controller: name,
      index: index,
      body: <String, dynamic>{
        'bulkData': documents,
      },
      waitForRefresh: waitForRefresh,
    ));

    final result = response.result as Map<String, dynamic>;
    if (result['successes'] is List && result['errors'] is List) {
      return result;
    }

    throw BadResponseFormatError(response.error?.id, 
      '$name.exists: bad response format', 
      response
    );
  }

  /// Creates or replaces
  /// large amounts of [documents] as fast as possible.
  Future<Map<String, dynamic>> mWrite(
      String index, 
      String collection, 
      List<Map<String, dynamic>> documents) async {
    final response = await kuzzle.query(KuzzleRequest(
      action: 'mWrite',
      collection: collection,
      controller: name,
      index: index,
      body: <String, dynamic>{
        'documents': documents,
      },
    ));

    final result = response.result as Map<String, dynamic>;
    if (result['successes'] is List && result['errors'] is List) {
      return result;
    }

    throw BadResponseFormatError(response.error?.id, 
      '$name.exists: bad response format', 
      response
    );
  }

  /// Creates or replaces a document
  Future<Map<String, dynamic>> write(
      String index, 
      String collection, 
      Map<String, dynamic> document, {
        String id,
        bool waitForRefresh = false,
      }) async {
    final response = await kuzzle.query(KuzzleRequest(
      action: 'write',
      collection: collection,
      controller: name,
      index: index,
      body: document,
      uid: id,
      waitForRefresh: waitForRefresh,
    ));

    if (response.result != null) {
      return response.result as Map<String, dynamic>;
    }

    throw BadResponseFormatError(response.error?.id, 
      '$name.exists: bad response format', 
      response
    );
  }
}
