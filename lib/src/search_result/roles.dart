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

  @override
  Future<SearchResult> next() async {
    if (fetched >= total) {
      return null;
    }

    if (request.scroll != null && request.scroll.isNotEmpty) {
      final query = KuzzleRequest(
        controller: controller,
        scrollId: response.result['scrollId'] as String,
      );
      
      return await kuzzle
          .query(query)
          .then((_response) {
        response = _response;

        final result = response.result as Map<String, dynamic>;

        if (result.containsKey('aggregations')) {
          aggregations = result['aggregations'] as Map<String, dynamic>;
        }
        if (result.containsKey('hits')) {
          hits = result['hits'] as List<dynamic>;
          fetched = fetched;
        }

        return buildNextSearchResult(response);
      });
    } else if (request.size != null && request.sort != null) {
      final _request = KuzzleRequest.clone(request)..action = searchAction;

      _request.body ??= <String, dynamic>{};
      _request.body['search_after'] ??= <dynamic>[];

      final hit = hits.last;

      for (var sort in request.sort) {
        final key =
            (sort is String) ? sort : (sort as Map<String, dynamic>).keys.first;
        final value = (key == '_uid')
            ? '${request.collection}#${hit['_id']}'
            : _get(hit['_source'] as Map<String, dynamic>, key.split('.'));

        _request.body['search_after'].add(value);
      }

      return await kuzzle.query(_request).then((_response) {
        response = _response;

        final result = response.result as Map<String, dynamic>;

        if (result.containsKey('aggregations')) {
          aggregations = result['aggregations'] as Map<String, dynamic>;
        }
        if (result.containsKey('hits')) {
          hits = result['hits'] as List<dynamic>;
          fetched = hits.length;
        }

        return buildNextSearchResult(response);
      });
    } else if (request.size != null) {

      if (request.from >= total) {
        return null;
      }

      return await kuzzle
          .query(KuzzleRequest.clone(request)
            ..action = searchAction
            ..from = fetched)
          .then((_response) {
        response = _response;

        final result = response.result as Map<String, dynamic>;

        if (result.containsKey('aggregations')) {
          aggregations = result['aggregations'] as Map<String, dynamic>;
        }
        if (result.containsKey('hits')) {
          hits = result['hits'] as List<dynamic>;
          fetched = fetched;
        }

        return buildNextSearchResult(response);
      });
    }

    throw KuzzleError('Unable to retrieve next results from search: '
        'missing scrollId, from/sort, or from/size params');
  }

  dynamic _get(Map<String, dynamic> object, List<String> path) {
    if (object == null) {
      return <String>[];
    }

    if (path.length == 1) {
      return object[path.first];
    }

    final key = path.first;
    path.removeAt(0);

    return _get(object[key] as Map<String, dynamic>, path);
  }

  List<KuzzleRole> getRoles() => List<KuzzleRole>.from(hits);
}
