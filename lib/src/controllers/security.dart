import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/profile.dart';
import '../kuzzle/request.dart';
import '../kuzzle/role.dart';
import '../kuzzle/user.dart';
import '../search_result/profiles.dart';
import '../search_result/roles.dart';
import '../search_result/users.dart';

import 'abstract.dart';

class SecurityController extends KuzzleController {
  SecurityController(Kuzzle kuzzle) : super(kuzzle, name: 'security');

  /// Creates authentication credentials for a user.
  Future<Map<String, dynamic>> createCredentials(
      String strategy, String uid, Map<String, dynamic> credentials) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createCredentials',
      strategy: strategy,
      uid: uid,
      body: credentials,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Creates a Kuzzle administrator account, only if none exist.
  Future<KuzzleUser> createFirstAdmin(
      String uid, Map<String, dynamic> credentials,
      {Map<String, dynamic> content, bool reset}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createFirstAdmin',
      uid: uid,
      reset: reset,
      body: <String, dynamic>{
        'content': content,
        'credentials': credentials,
      },
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new profile or, if the provided profile
  /// identifier already exists, replaces it.
  Future<KuzzleProfile> createOrReplaceProfile(
      String uid, List<Map<String, dynamic>> policies,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createOrReplaceProfile',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'policies': policies,
      },
    ));

    return KuzzleProfile.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new role or, if the provided role
  /// identifier already exists, replaces it.
  Future<KuzzleRole> createOrReplaceRole(
      String uid, Map<String, dynamic> controllers,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createOrReplaceRole',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'controllers': controllers,
      },
    ));

    return KuzzleRole.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new profile.
  Future<KuzzleProfile> createProfile(
      String uid, List<Map<String, dynamic>> policies,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createProfile',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'policies': policies,
      },
    ));

    return KuzzleProfile.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new user in Kuzzle, with a preset list of security profiles.
  ///
  /// The list of security profiles attributed to restricted users is fixed,
  /// and must be configured in the Kuzzle configuration file.
  ///
  /// This method allows users with limited rights to create other accounts,
  /// but blocks them from creating accounts with unwanted privileges
  /// (e.g. an anonymous user creating his own account).
  Future<KuzzleUser> createRestrictedUser(Map<String, dynamic> credentials,
      {Map<String, dynamic> content, String uid, bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createRestrictedUser',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'content': content,
        'credentials': credentials,
      },
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new role.
  Future<KuzzleRole> createRole(String uid, Map<String, dynamic> controllers,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createRole',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'controllers': controllers,
      },
    ));

    return KuzzleRole.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new user
  Future<KuzzleUser> createUser(
      Map<String, dynamic> credentials, Map<String, dynamic> content,
      {String uid, bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createUser',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'content': content,
        'credentials': credentials,
      },
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Deletes user credentials for the specified authentication strategy.
  Future<Map<String, dynamic>> deleteCredentials(
      String strategy, String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteCredentials',
      strategy: strategy,
      uid: uid,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes a security profile.
  /// An error is returned if the profile is still in use.
  Future<Map<String, dynamic>> deleteProfile(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteProfile',
      uid: uid,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes a security role.
  /// An error is returned if the role is still in use.
  Future<Map<String, dynamic>> deleteRole(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteRole',
      uid: uid,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes a user and all their associate credentials.
  Future<Map<String, dynamic>> deleteUser(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteUser',
      uid: uid,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Retrieves the list of fields accepted by authentication strategies.
  Future<Map<String, dynamic>> getAllCredentialFields() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getAllCredentialFields',
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Retrieves the list of accepted field names by
  /// the specified authentication strategy.
  Future<Map<String, dynamic>> getCredentialFields(String strategy) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getCredentialFields',
      strategy: strategy,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets a user's credential information for
  /// the specified authentication strategy.
  ///
  /// The returned content depends on the authentication strategy,
  /// but it should never include sensitive information.
  Future<Map<String, dynamic>> getCredentials(
      String strategy, String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getCredentials',
      strategy: strategy,
      uid: uid,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets credential information for the user identified by
  /// the strategy's unique user identifier userId
  ///
  /// The returned result object will vary depending on
  /// the strategy (see the getById plugin function), and it can be empty.
  ///
  /// Note: the user identifier to use depends on the specified strategy.
  /// If you wish to get credential information using a kuid identifier,
  /// use the getCredentials API route instead.
  Future<Map<String, dynamic>> getCredentialsById(
      String strategy, String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getCredentialsById',
      strategy: strategy,
      uid: uid,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets a security profile.
  Future<KuzzleProfile> getProfile(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getProfile',
      uid: uid,
    ));

    return KuzzleProfile.fromKuzzleResponse(kuzzle, response);
  }

  /// Gets the mapping of the internal security profiles collection.
  Future<Map<String, dynamic>> getProfileMapping() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getProfileMapping',
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets the detailed rights configured by a security profile.
  Future<Map<String, dynamic>> getProfileRights(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getProfileRights',
      uid: uid,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets a security role.
  Future<KuzzleRole> getRole(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getRole',
      uid: uid,
    ));

    return KuzzleRole.fromKuzzleResponse(kuzzle, response);
  }

  /// Gets the mapping of the internal security role collection.
  Future<Map<String, dynamic>> getRoleMapping() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getRoleMapping',
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets a security role.
  Future<KuzzleUser> getUser(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getUser',
      uid: uid,
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Gets the mapping of the internal security user collection.
  Future<Map<String, dynamic>> getUserMapping() async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getUserMapping',
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets the detailed rights granted to a user.
  Future<List<dynamic>> getUserRights(String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getUserRights',
      uid: uid,
    ));

    return response.result['hits'] as List<dynamic>;
  }

  /// Checks if a user has credentials registered
  /// for the specified authentication strategy.
  Future<bool> hasCredentials(String strategy, String uid) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'hasCredentials',
      strategy: strategy,
      uid: uid,
    ));

    if (response.result is bool) {
      return response.result as bool;
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.hasCredentials: bad response format', 
      response
    );
  }

  /// Deletes multiple security profiles.
  Future<Map<String, dynamic>> mDeleteProfiles(List<String> ids,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mDeleteProfiles',
        body: <String, dynamic>{
          'ids': ids,
        }));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes multiple security roles.
  Future<Map<String, dynamic>> mDeleteRoles(List<String> ids,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mDeleteRoles',
        body: <String, dynamic>{
          'ids': ids,
        }));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes multiple security users.
  Future<Map<String, dynamic>> mDeleteUsers(List<String> ids,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mDeleteUsers',
        body: <String, dynamic>{
          'ids': ids,
        }));

    return response.result as Map<String, dynamic>;
  }

  /// Gets multiple security profiles.
  Future<List<KuzzleProfile>> mGetProfiles(List<String> ids,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mGetProfiles',
        body: <String, dynamic>{
          'ids': ids,
        }));

    final profiles = <KuzzleProfile>[];

    for (final hit in response.result['hits']) {
      profiles.add(KuzzleProfile(kuzzle,
          uid: hit['_id'] as String,
          policies: hit['_source']['policies'] as List<dynamic>));
    }

    return profiles;
  }

  /// Gets multiple security roles.
  Future<List<KuzzleRole>> mGetRoles(List<String> ids, {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mGetRoles',
        body: <String, dynamic>{
          'ids': ids,
        }));

    final roles = <KuzzleRole>[];

    for (final hit in response.result['hits']) {
      roles.add(KuzzleRole(kuzzle,
          uid: hit['_id'] as String,
          controllers: hit['_source']['controllers'] as Map<String, dynamic>));
    }

    return roles;
  }

  /// Replaces a user with new configuration.
  Future<KuzzleUser> replaceUser(Map<String, dynamic> content,
      {String uid, bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'replaceUser',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: content,
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Searches security profiles, optionally returning
  /// only those linked to the provided list of security roles.
  Future<ProfileSearchResult> searchProfiles(
      {Map<String, dynamic> query, int from, int size, String scroll}) async {
    final request = KuzzleRequest(
      controller: name,
      action: 'searchProfiles',
      body: query,
      from: from,
      size: size,
      scroll: scroll,
    );
    final response = await kuzzle.query(request);

    return ProfileSearchResult(kuzzle, request: request, response: response);
  }

  /// Searches security roles, optionally returning only
  /// those allowing access to the provided controllers.
  Future<RoleSearchResult> searchRoles(
      {Map<String, dynamic> query, int from, int size}) async {
    final request = KuzzleRequest(
      controller: name,
      action: 'searchRoles',
      body: query,
      from: from,
      size: size,
    );
    final response = await kuzzle.query(request);

    return RoleSearchResult(kuzzle, request: request, response: response);
  }

  /// Searches security profiles, optionally returning
  /// only those linked to the provided list of security roles.
  Future<UserSearchResult> searchUsers(
      {Map<String, dynamic> query, int from, int size, String scroll}) async {
    final request = KuzzleRequest(
      controller: name,
      action: 'searchUsers',
      body: query,
      from: from,
      size: size,
      scroll: scroll,
    );
    final response = await kuzzle.query(request);

    return UserSearchResult(kuzzle, request: request, response: response);
  }

  /// Updates a user credentials for the specified authentication strategy.
  Future<Map<String, dynamic>> updateCredentials(
      String strategy, String uid, Map<String, dynamic> credentials) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateCredentials',
      strategy: strategy,
      uid: uid,
      body: credentials,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a security profile definition.
  Future<KuzzleProfile> updateProfile(String uid, List<dynamic> policies,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateProfile',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'policies': policies,
      },
    ));

    return KuzzleProfile.fromKuzzleResponse(kuzzle, response);
  }

  /// Updates the internal profile storage mapping.
  Future<Map<String, dynamic>> updateProfileMapping(
      Map<String, dynamic> properties) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateProfileMapping',
      body: <String, dynamic>{
        'properties': properties,
      },
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a security role definition
  ///
  /// Note: partial updates are not supported for roles,
  /// this API route will replace the entire role content with the provided one.
  Future<KuzzleRole> updateRole(String uid, Map<String, dynamic> controllers,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateRole',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'controllers': controllers,
      },
    ));

    return KuzzleRole.fromKuzzleResponse(kuzzle, response);
  }

  /// Updates the internal role storage mapping.
  Future<Map<String, dynamic>> updateRoleMapping(
      Map<String, dynamic> properties) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateRoleMapping',
      body: <String, dynamic>{
        'properties': properties,
      },
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a user definition.
  Future<KuzzleUser> updateUser(Map<String, dynamic> content,
      {String uid, bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateUser',
      uid: uid,
      waitForRefresh: waitForRefresh,
      body: content,
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Updates the internal user storage mapping.
  Future<Map<String, dynamic>> updateUserMapping(
      Map<String, dynamic> properties) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateUserMapping',
      body: <String, dynamic>{
        'properties': properties,
      },
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Checks if the provided credentials are well-formed.
  /// Does not actually save credentials.
  Future<bool> validateCredentials(
      String strategy, String uid, Map<String, dynamic> credentials) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'validateCredentials',
      strategy: strategy,
      uid: uid,
      body: credentials,
    ));

    if (response.result is bool) {
      return response.result as bool;
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.validateCredentials: bad response format', 
      response
    );
  }
}
