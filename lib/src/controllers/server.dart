import '../kuzzle.dart';
import '../kuzzle/errors.dart';

import 'abstract.dart';

class ServerController extends KuzzleController {
  ServerController(Kuzzle kuzzle) : super(kuzzle, name: 'server');

  /// Checks if an administrator user exists
  Future<bool> adminExists() async {
    final response = await kuzzle.query({'controller': name, 'action': 'now'});

    if (response.result != null && response.result.containsKey('exists')) {
      if (response.result['exists'] is bool) {
        return response.result['exists'] as bool;
      }
    }

    return Future.error(
        BadResponseFormatError('adminExists: bad response format', response));
  }

  /// Returns all stored statistics frames
  Future<Map<String, dynamic>> getAllStats() async {
    final response =
        await kuzzle.query({'controller': name, 'action': 'getAllStats'});

    return response.result;
  }

  /// Returns the Kuzzle configuration
  Future<Map<String, dynamic>> getConfig() async {
    final response =
        await kuzzle.query({'controller': name, 'action': 'getConfig'});

    return response.result;
  }

  /// Returns the last statistics frame
  Future<Map<String, dynamic>> getLastStats() async {
    final response =
        await kuzzle.query({'controller': name, 'action': 'getLastStats'});

    return response.result;
  }

  /// Returns the statistics frame from a date
  Future<Map<String, dynamic>> getStats(
      DateTime startTime, DateTime stopTime) async {
    final response = await kuzzle.query({
      'controller': name,
      'action': 'getAllStats',
      'startTime': startTime,
      'stopTime': stopTime
    });

    return response.result;
  }

  /// Returns the Kuzzle server information
  Future<Map<String, dynamic>> info() async {
    final response = await kuzzle.query({'controller': name, 'action': 'info'});

    return response.result;
  }

  /// Get server's current timestamp
  Future<DateTime> now() async {
    final response = await kuzzle.query({'controller': name, 'action': 'now'});

    if (response.result != null && response.result.containsKey('now')) {
      if (response.result['now'] is int) {
        return DateTime.fromMillisecondsSinceEpoch(
            response.result['now'] as int);
      }
    }

    return Future.error(
        BadResponseFormatError('now: bad response format', response));
  }
}
