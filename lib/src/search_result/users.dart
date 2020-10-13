import '../kuzzle.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';
import '../kuzzle/user.dart';

import 'search-result.dart';

class UserSearchResult extends SearchResult {
  UserSearchResult(
    Kuzzle kuzzle, {
    KuzzleRequest request,
    KuzzleResponse response,
  }) : super(kuzzle, request: request, response: response) {
    searchAction = 'searchUsers';
    scrollAction = 'scrollUsers';

    hits = response.result['hits']
        .map((hit) => KuzzleUser(kuzzle,
            uid: hit['_id'] as String,
            content: hit['_source'] as Map<String, dynamic>,
            meta: hit['_meta'] as Map<String, dynamic>))
        .toList() as List<dynamic>;
  }

  @override
  UserSearchResult buildNextSearchResult (KuzzleResponse response) {
    final nextSearchResult = UserSearchResult(
      kuzzle, 
      request: request, 
      response: response);
    nextSearchResult.fetched += fetched;
    return nextSearchResult;
  }

  List<KuzzleUser> getUsers() => List<KuzzleUser>.from(hits);
}
