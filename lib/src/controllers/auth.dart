import 'dart:async';

import 'package:kuzzle/src/protocols/events.dart';

import '../kuzzle.dart';
import '../kuzzle/request.dart';
import '../kuzzle/user.dart';

import 'abstract.dart';

class AuthController extends KuzzleController {
  AuthController(Kuzzle kuzzle) : super(kuzzle, name: 'auth');

  /// Checks whether a given jwt [token] still
  /// represents a valid session in Kuzzle.
  Future<Map<String, dynamic>> checkToken(String token) async {
    final response = await kuzzle.query(
        KuzzleRequest(
            controller: name,
            action: 'checkToken',
            body: <String, dynamic>{'token': token}),
        queueable: false);

    return response.result as Map<String, dynamic>;
  }

  /// Create [credentials] of the specified [strategy] for the current user.
  Future<Map<String, dynamic>> createMyCredentials(
      String strategy, Map<String, dynamic> credentials) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createMyCredentials',
      strategy: strategy,
      body: credentials,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Check the existence of the specified [strategy]'s
  /// credentials for the current user.
  Future<bool> credentialsExist(String strategy) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'credentialsExist',
      strategy: strategy,
    ));

    return response.result as bool;
  }

  /// Delete credentials of the specified [strategy] for the current user.
  Future<Map<String, dynamic>> deleteMyCredentials(String strategy) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteMyCredentials',
      strategy: strategy,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Fetches the current user.
  Future<KuzzleUser> getCurrentUser() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getCurrentUser',
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Get credential information of
  /// the specified [strategy] for the current user.
  Future<Map<String, dynamic>> getMyCredentials(String strategy) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getMyCredentials',
      strategy: strategy,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets the rights array of the currently logged user
  Future<List<Map<String, dynamic>>> getMyRights() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getMyRights',
    ));

    return (response.result['hits'] as List<dynamic>)
        .map<Map<String, dynamic>>((a) => a as Map<String, dynamic>)
        .toList();
  }

  /// Get all the strategies registered in Kuzzle by all auth plugins
  Future<List<String>> getStrategies() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getStrategies',
    ));

    return (response.result as List<dynamic>)
        .map<String>((a) => a as String)
        .toList();
  }

  /// Send login request to kuzzle with credentials
  ///
  /// If login success, store the jwt into kuzzle object
  Future<String> login(String strategy, Map<String, dynamic> credentials,
          {String expiresIn}) async =>
      kuzzle
          .query(KuzzleRequest(
        controller: name,
        action: 'login',
        strategy: strategy,
        expiresIn: expiresIn,
        body: credentials,
      ))
          .then((response) {
        try {
          kuzzle.jwt = response.result['jwt'] as String;
          kuzzle.emit(ProtocolEvents.LOGIN_ATTEMPT, [], {
            const Symbol('success'): true,
          });

          return kuzzle.jwt;
        } on Exception {
          rethrow;
        }
      }).catchError((error) {
        kuzzle.emit(ProtocolEvents.LOGIN_ATTEMPT, [], {
          const Symbol('success'): false,
          const Symbol('error'): error,
        });

        throw error;
      });

  /// Send logout request to kuzzle with jwt.
  Future<void> logout() async => kuzzle
          .query(KuzzleRequest(
        controller: name,
        action: 'logout',
      ))
          .then((response) {
        kuzzle.jwt = null;
      });

  /// Update [credentials] of the specified [strategy] for the current user.
  Future<Map<String, dynamic>> updateMyCredentials(
      String strategy, Map<String, dynamic> credentials) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateMyCredentials',
      strategy: strategy,
      body: credentials,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Fetches the current user.
  Future<KuzzleUser> updateSelf(Map<String, dynamic> body) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateSelf',
      body: body,
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Validate [credentials] of the specified [strategy] for the current user.
  Future<bool> validateMyCredentials(
      String strategy, Map<String, dynamic> credentials) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'validateMyCredentials',
      strategy: strategy,
      body: credentials,
    ));

    return response.result as bool;
  }
}
