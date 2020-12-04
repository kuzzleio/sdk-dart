import '../kuzzle.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';

import 'search-result.dart';

class SpecificationSearchResult extends SearchResult {
  SpecificationSearchResult(
    Kuzzle kuzzle, {
    KuzzleRequest request,
    KuzzleResponse response,
  }) : super(kuzzle, request: request, response: response) {
    controller = 'collection';
    searchAction = 'searchSpecifications';
    scrollAction = 'scrollSpecifications';
  }
}
