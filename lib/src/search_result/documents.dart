import '../kuzzle.dart';
import '../kuzzle/request.dart';
import '../kuzzle/response.dart';

import 'search-result.dart';

class DocumentsSearchResult extends SearchResult {
  DocumentsSearchResult(
    Kuzzle kuzzle, {
    KuzzleRequest request,
    KuzzleResponse response,
  }) : super(kuzzle, request: request, response: response) {
    controller = 'documents';
    searchAction = 'search';
    scrollAction = 'scroll';
  }
}
