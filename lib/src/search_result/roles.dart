import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';
import '../kuzzle/role.dart';

import 'search-result.dart';

class RoleSearchResult extends SearchResult {
  RoleSearchResult(
    Kuzzle kuzzle, {
    KuzzleRequest request,
    KuzzleResponse response,
  }) : super(kuzzle, request: request, response: response) {
    searchAction = 'searchRoles';
    scrollAction = null; // scrollRoles action does not exists in Kuzzle API.

    hits = (response.result['hits'] as List).map((hit) => KuzzleRole(kuzzle,
            uid: hit['_id'] as String,
            controllers: hit['_source']['controllers'] as Map<String, dynamic>))
        .toList();
  }

  @override
  RoleSearchResult buildNextSearchResult (KuzzleResponse response) {
    final nextSearchResult = RoleSearchResult(
      kuzzle, 
      request: request, 
      response: response);
    nextSearchResult.fetched += fetched;
    return nextSearchResult;
  }

  List<KuzzleRole> getRoles() => List<KuzzleRole>.from(hits);
}
