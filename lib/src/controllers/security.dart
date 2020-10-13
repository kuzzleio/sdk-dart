import 'package:kuzzle/src/search_result/search-result.dart';

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

  /// Creates a new API key for a user.
  Future<Map<String, dynamic>> createApiKey(
      String userId, String description,
      {String expiresIn, bool refresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createApiKey',
      userId: userId,
      body: <String, dynamic>{
        'description': description,
      },
      waitForRefresh: refresh,
      expiresIn: expiresIn
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Creates authentication credentials for a user.
  Future<Map<String, dynamic>> createCredentials(
      String strategy,
      String id,
      Map<String, dynamic> credentials,
      {bool refresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createCredentials',
      strategy: strategy,
      uid: id,
      body: credentials,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Creates a Kuzzle administrator account, only if none exist.
  Future<KuzzleUser> createFirstAdmin(
      String id, Map<String, dynamic> body,
      {bool reset}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createFirstAdmin',
      uid: id,
      reset: reset,
      body: body,
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new profile or, if the provided profile
  /// identifier already exists, replaces it.
  Future<KuzzleProfile> createOrReplaceProfile(
      String id, List<Map<String, dynamic>> policies,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createOrReplaceProfile',
      uid: id,
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
      String id, Map<String, dynamic> controllers,
      {bool waitForRefresh, bool force,}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createOrReplaceRole',
      uid: id,
      force: force,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'controllers': controllers,
      },
    ));

    return KuzzleRole.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new profile.
  Future<KuzzleProfile> createProfile(
      String id, List<Map<String, dynamic>> policies,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createProfile',
      uid: id,
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
  Future<KuzzleUser> createRestrictedUser(Map<String, dynamic> body, String id,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createRestrictedUser',
      uid: id,
      waitForRefresh: waitForRefresh,
      body: body
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new role.
  Future<KuzzleRole> createRole(String id, Map<String, dynamic> controllers,
      {bool waitForRefresh, bool force}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createRole',
      uid: id,
      waitForRefresh: waitForRefresh,
      force: force,
      body: <String, dynamic>{
        'controllers': controllers,
      },
    ));

    return KuzzleRole.fromKuzzleResponse(kuzzle, response);
  }

  /// Creates a new user
  Future<KuzzleUser> createUser(String id, 
      Map<String, dynamic> body,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createUser',
      uid: id,
      waitForRefresh: waitForRefresh,
      body: body
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Deletes user API key.
  Future<Null> deleteApiKey(
      String userId, String id, {bool waitForRefresh}) async {
    await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteApiKey',
      userId: userId,
      uid: id,
      waitForRefresh: waitForRefresh,
    ));

    return null;
  }

  /// Deletes user credentials for the specified authentication strategy.
  Future<Map<String, dynamic>> deleteCredentials(
      String strategy, String id, {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteCredentials',
      strategy: strategy,
      uid: id,
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes a security profile.
  /// An error is returned if the profile is still in use.
  Future<Map<String, dynamic>> deleteProfile(String id,
  {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteProfile',
      uid: id,
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes a security role.
  /// An error is returned if the role is still in use.
  Future<Map<String, dynamic>> deleteRole(String id,
  {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteRole',
      uid: id,
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes a user and all their associate credentials.
  Future<Map<String, dynamic>> deleteUser(String id,
  {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteUser',
      uid: id,
      waitForRefresh: waitForRefresh,
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
  Future<List<dynamic>> getCredentialFields(
    String strategy) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getCredentialFields',
      strategy: strategy,
    ));

    return response.result as List<dynamic>;
  }

  /// Gets a user's credential information for
  /// the specified authentication strategy.
  ///
  /// The returned content depends on the authentication strategy,
  /// but it should never include sensitive information.
  Future<Map<String, dynamic>> getCredentials(
      String strategy, String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getCredentials',
      strategy: strategy,
      uid: id,
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
      String strategy, String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getCredentialsById',
      strategy: strategy,
      uid: id,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets a security profile.
  Future<KuzzleProfile> getProfile(String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getProfile',
      uid: id,
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
  Future<List<dynamic>> getProfileRights(String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getProfileRights',
      uid: id,
    ));

    return response.result['hits'] as List<dynamic>;
  }

  /// Gets a security role.
  Future<KuzzleRole> getRole(String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getRole',
      uid: id,
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
  Future<KuzzleUser> getUser(String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getUser',
      uid: id,
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
  Future<List<dynamic>> getUserRights(String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getUserRights',
      uid: id,
    ));

    return response.result['hits'] as List<dynamic>;
  }

  /// Checks if a user has credentials registered
  /// for the specified authentication strategy.
  Future<bool> hasCredentials(String strategy, String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'hasCredentials',
      strategy: strategy,
      uid: id,
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
  Future<List<dynamic>> mDeleteProfiles(List<String> ids,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mDeleteProfiles',
        body: <String, dynamic>{
          'ids': ids,
        }));

    return response.result as List<dynamic>;
  }

  /// Deletes multiple security roles.
  Future<List<dynamic>> mDeleteRoles(List<String> ids,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mDeleteRoles',
        body: <String, dynamic>{
          'ids': ids,
        }));

    return response.result as List<dynamic>;
  }

  /// Deletes multiple security users.
  Future<List<dynamic>> mDeleteUsers(List<String> ids,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mDeleteUsers',
        body: <String, dynamic>{
          'ids': ids,
        }));

    return response.result as List<dynamic>;
  }

  /// Gets multiple security profiles.
  Future<List<KuzzleProfile>> mGetProfiles(List<String> ids) async {
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
  Future<List<KuzzleRole>> mGetRoles(
    List<String> ids) async {
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

  /// Gets multiple security roles.
  Future<List<KuzzleUser>> mGetUsers(
    List<String> ids, {String verb}) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        action: 'mGetUsers',
        verb: verb,
        body: <String, dynamic>{
          'ids': ids,
        }));

    final users = <KuzzleUser>[];

    for (final hit in response.result['hits']) {
      users.add(KuzzleUser(kuzzle,
          uid: hit['_id'] as String,
          content: hit['_source'] as Map<String, dynamic>));
    }

    return users;
  }

  /// Forces an immediate reindexation of the provided security collection.
  Future<bool> refresh(String collection) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'refresh',
      collection: collection
    ));

    return response.status == 200 && response.result == null;
  }

  /// Replaces a user with new configuration.
  Future<KuzzleUser> replaceUser(String id, Map<String, dynamic> body,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'replaceUser',
      uid: id,
      waitForRefresh: waitForRefresh,
      body: body,
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Searches for a user API keys.
  Future<SearchResult> searchApiKeys(String userId, Map<String, dynamic> query,
      {int from, int size}) async {
    final request = KuzzleRequest(
      controller: name,
      action: 'searchApiKeys',
      userId: userId,
      body: query,
      from: from,
      size: size,
    );

    final response = await kuzzle.query(request);
    return SearchResult(kuzzle, request: request, response: response);
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
      String strategy, String id, Map<String, dynamic> credentials,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateCredentials',
      strategy: strategy,
      uid: id,
      body: credentials,
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a security profile definition.
  Future<KuzzleProfile> updateProfile(String id, List<dynamic> policies,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateProfile',
      uid: id,
      waitForRefresh: waitForRefresh,
      body: <String, dynamic>{
        'policies': policies,
      },
    ));

    return KuzzleProfile.fromKuzzleResponse(kuzzle, response);
  }

  /// Updates the internal profile storage mapping.
  Future<Map<String, dynamic>> updateProfileMapping(
      Map<String, dynamic> mapping) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateProfileMapping',
      body: mapping
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a security role definition
  ///
  /// Note: partial updates are not supported for roles,
  /// this API route will replace the entire role content with the provided one.
  Future<KuzzleRole> updateRole(String id, Map<String, dynamic> body,
      {bool waitForRefresh, bool force}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateRole',
      uid: id,
      force: force,
      waitForRefresh: waitForRefresh,
      body: body,
    ));

    return KuzzleRole.fromKuzzleResponse(kuzzle, response);
  }

  /// Updates the internal role storage mapping.
  Future<Map<String, dynamic>> updateRoleMapping(
      Map<String, dynamic> mapping) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateRoleMapping',
      body: mapping,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a user definition.
  Future<KuzzleUser> updateUser(String id, Map<String, dynamic> body,
      {bool waitForRefresh}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateUser',
      uid: id,
      waitForRefresh: waitForRefresh,
      body: body,
    ));

    return KuzzleUser.fromKuzzleResponse(kuzzle, response);
  }

  /// Updates the internal user storage mapping.
  Future<Map<String, dynamic>> updateUserMapping(
      Map<String, dynamic> mapping) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateUserMapping',
      body: mapping
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Checks if the provided credentials are well-formed.
  /// Does not actually save credentials.
  Future<bool> validateCredentials(
      String strategy, String id, Map<String, dynamic> credentials) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'validateCredentials',
      strategy: strategy,
      uid: id,
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
