import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import 'abstract.dart';

class ServerController extends KuzzleController {
  ServerController(Kuzzle kuzzle) : super(kuzzle, name: 'server');

  /// Checks if an administrator user exists
  Future<bool> adminExists() async {
    final response = await kuzzle
        .query(KuzzleRequest(controller: name, action: 'adminExists'));

    final result = response.result as Map<String, dynamic>;

    if (result != null && result.containsKey('exists')) {
      if (result['exists'] is bool) {
        return result['exists'] as bool;
      }
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.adminExists: bad response format', 
      response
    );
  }

  /// Returns all stored statistics frames
  Future<Map<String, dynamic>> getAllStats() async {
    final response = await kuzzle
        .query(KuzzleRequest(controller: name, action: 'getAllStats'));

    return response.result as Map<String, dynamic>;
  }

  /// Returns the Kuzzle configuration
  Future<Map<String, dynamic>> getConfig() async {
    final response = await kuzzle
        .query(KuzzleRequest(controller: name, action: 'getConfig'));

    return response.result as Map<String, dynamic>;
  }

  /// Returns the last statistics frame
  Future<Map<String, dynamic>> getLastStats() async {
    final response = await kuzzle
        .query(KuzzleRequest(controller: name, action: 'getLastStats'));

    return response.result as Map<String, dynamic>;
  }

  /// Returns the statistics frame from a date
  Future<Map<String, dynamic>> getStats(
      DateTime startTime, DateTime stopTime) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getAllStats',
      startTime: startTime,
      stopTime: stopTime,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Returns the Kuzzle server information
  Future<Map<String, dynamic>> info() async {
    final response =
        await kuzzle.query(KuzzleRequest(controller: name, action: 'info'));

    return response.result as Map<String, dynamic>;
  }

  /// Get server's current timestamp
  Future<DateTime> now() async {
    final response =
        await kuzzle.query(KuzzleRequest(controller: name, action: 'now'));

    final result = response.result as Map<String, dynamic>;

    if (result != null && result.containsKey('now')) {
      if (result['now'] is int) {
        return DateTime.fromMillisecondsSinceEpoch(result['now'] as int);
      }
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.now: bad response format', 
      response
    );
  }
}
