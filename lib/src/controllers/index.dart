import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import 'abstract.dart';

class IndexController extends KuzzleController {
  IndexController(Kuzzle kuzzle) : super(kuzzle, name: 'index');

  /// Creates a new data [index] in Kuzzle.
  Future<bool> create(String index) async {
    final response = await kuzzle.query(KuzzleRequest(
      action: 'create',
      controller: name,
      index: index,
    ));

    return response.status == 200;
  }

  /// Delete an [index] from Kuzzle.
  /// returns true if achnowledged
  Future<bool> delete(String index) async {
    final response = await kuzzle.query(KuzzleRequest(
      action: 'delete',
      controller: name,
      index: index,
    ));

    return (response.result as Map<String, dynamic>)['acknowledged'] as bool;
  }

  /// Checks if the given [index] exists in Kuzzle.
  Future<bool> exists(String index) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'exists',
      index: index,
    ));

    if (response.result != null) {
      if (response.result is bool) {
        return response.result as bool;
      }
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.exists: bad response format', 
      response
    );
  }

  /// Returns the complete list of data indexes.
  Future<List<String>> list() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'list',
    ));

    final result = response.result as Map<String, dynamic>;

    if (result != null && result.containsKey('indexes')) {
      if (result['indexes'] is List) {
        return (result['indexes'] as List<dynamic>).map<String>((a) => a as String).toList();
      }
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.list: bad response format', 
      response
    );
  }

  /// Deletes multiple indexes.
  Future<List<String>> mDelete(List<String> indexes) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'mDelete',
      body: <String, dynamic>{'indexes': indexes},
    ));

    final result = response.result as Map<String, dynamic>;

    if (result != null && result.containsKey('deleted')) {
      if (result['deleted'] is List<dynamic>) {
        return List<String>.from(result['deleted'] as List<dynamic>);
      }
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.mDelete: bad response format', 
      response
    );
  }
}
