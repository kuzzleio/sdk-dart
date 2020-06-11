import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';
import '../kuzzle/role.dart';

import 'abstract.dart';

class RoleSearchResult extends SearchResult {
  RoleSearchResult(
    Kuzzle kuzzle, {
    KuzzleRequest request,
    KuzzleResponse response,
  }) : super(kuzzle, request: request, response: response) {
    controller = null;
    searchAction = 'searchRoles';
    scrollAction = null; // scrollRoles action does not exists in Kuzzle API.

    hits = (response.result['hits'] as List).map((hit) => KuzzleRole(kuzzle,
            uid: hit['_id'] as String,
            controllers: hit['_source']['controllers'] as Map<String, dynamic>))
        .toList();
  }

  // @override
  // Future<List<dynamic>> next() {
  //   if (request.scroll != null || request.sort != null) {
  //     throw KuzzleError('only from/size params are allowed for role search');
  //   }

  //   return super.next().then((_) => hits = (response.result['hits'] as List)
  //       .map((hit) => KuzzleRole(kuzzle,
  //           uid: hit['_id'] as String,
  //           controllers: hit['_source']['controllers']
  //               as Map<String, dynamic>)) as List<dynamic>);
  // }

  List<KuzzleRole> getRoles() => List<KuzzleRole>.from(hits);
}
