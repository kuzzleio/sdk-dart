import '../kuzzle.dart';
import '../kuzzle/response.dart';

import 'role.dart';

class KuzzleProfile {
  KuzzleProfile(
    this.kuzzle, {
    this.uid,
    this.policies,
  });

  KuzzleProfile.fromKuzzleResponse(this.kuzzle, KuzzleResponse response) {
    uid = response.result['_id'] as String;
    policies = response.result['_source']['policies'] as List<dynamic>;
  }

  final Kuzzle kuzzle;
  String uid;
  List<dynamic> policies;

  List<String> get roleIds => policies
    .map((policy) => policy['roleId'] as String).toList();
  
  Future<List<KuzzleRole>> getRoles() async {
    if (policies == null || policies.isEmpty) {
      return <KuzzleRole>[];
    }

    return kuzzle.security.mGetRoles(roleIds);
  }
}
