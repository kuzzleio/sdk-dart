import '../kuzzle.dart';
import '../kuzzle/profile.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';

import 'search-result.dart';

class ProfileSearchResult extends SearchResult {
  ProfileSearchResult(
    Kuzzle kuzzle, {
    KuzzleRequest request,
    KuzzleResponse response,
  }) : super(kuzzle, request: request, response: response) {
    searchAction = 'searchProfiles';
    scrollAction = 'scrollProfiles';

    hits = (response.result['hits'] as List)
        .map((hit) => KuzzleProfile(kuzzle,
            uid: hit['_id'] as String,
            policies: hit['_source']['policies'] as List))
        .toList();
  }

  @override
  ProfileSearchResult buildNextSearchResult (KuzzleResponse response) {
    final nextSearchResult = ProfileSearchResult(
      kuzzle, 
      request: request, 
      response: response);
    nextSearchResult.fetched += fetched;
    return nextSearchResult;
  }

  List<KuzzleProfile> getRoles() => List<KuzzleProfile>.from(hits);
}
