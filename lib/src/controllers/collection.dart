import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import '../search_result/specifications.dart';

import 'abstract.dart';

class CollectionController extends KuzzleController {
  CollectionController(Kuzzle kuzzle) : super(kuzzle, name: 'collection');

  /// Creates a new [collection], in the provided [index].
  ///
  /// You can also provide an optional [mapping]
  /// that allow you to exploit the full capabilities
  /// of our persistent data storage layer.
  Future<Map<String, dynamic>> create(
    String index,
    String collection, {
    Map<String, dynamic> mapping,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'create',
      index: index,
      collection: collection,
      body: mapping,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes validation specifications for a data collection.
  ///
  /// The request succeeds even if no specification
  /// exist for that data collection.
  ///
  /// Note: an empty specification is implicitly applied to all collections.
  /// In a way, "no specification set" means "all documents are valid".
  Future<Map<String, dynamic>> deleteSpecifications(
    String index, String collection) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteSpecifications',
      index: index,
      collection: collection,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Checks whether a [collection] exists in the [index].
  Future<bool> exists(String index, String collection) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'exists',
      index: index,
      collection: collection,
    ));

    if (response.result is bool) {
      return response.result as bool;
    }

    throw BadResponseFormatError(response.error?.id, 
      '$name.exists: bad response format', 
      response
    );
  }

  /// Returns a data [collection] mapping.
  Future<Map<String, dynamic>> getMapping(String index, String collection,
      {bool includeKuzzleMeta = false}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'getMapping',
      index: index,
      collection: collection,
      includeKuzzleMeta: includeKuzzleMeta,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Returns the validation specifications associated to the [collection].
  Future<Map<String, dynamic>> getSpecifications(
    String index, String collection) async {
    final request = KuzzleRequest(
      controller: name,
      action: 'getSpecifications',
      index: index,
      collection: collection,
    );

    final response = await kuzzle.query(request);

    return response.result as Map<String, dynamic>;
  }

  /// Returns the list of data collections associated to a provided data index.
  ///
  /// The returned list is sorted in alphanumerical order.
  Future<Map<String, dynamic>> list(
    String index, {int from, int size, String type}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'list',
      index: index,
      from: from,
      size: size,
      type: type,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Forces an immediate reindexation of the provided collection.
  ///
  /// When writing or deleting documents in Kuzzle, the changes need to be
  /// indexed before being reflected in the search results.
  /// By default, this operation can take up to 1 second.
  ///
  /// **Warning** Forcing immediate refreshes comes with performance costs,
  /// and should only performed when absolutely necessary.
  Future<bool> refresh(String index, String collection) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'refresh',
      index: index,
      collection: collection,
    ));

    return response.status == 200 && response.result == null;
  }

  /// [scroll] is Time to live. It resets the cursor
  /// - d - days
  /// - h - hours
  /// - m - minutes
  /// - s - seconds
  /// - ms - milliseconds
  /// - micros - microseconds
  /// - nanos - nanoseconds
  ///
  /// like: 2d for 2days
  ///
  /// https://www.elastic.co/guide/en/elasticsearch/reference/5.4/common-options.html#time-units
  /// TODO: remove index, and collection if not needed
  Future<Map<String, dynamic>> scrollSpecifications(
    String index,
    String collection,
    String scrollId,
    String scroll,
  ) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'scrollSpecifications',
      scrollId: scrollId,
      scroll: scroll,
      index: index,
      collection: collection,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Searches collection specifications.
  Future<SpecificationSearchResult> searchSpecifications(
    String index, {
    Map<String, dynamic> query,
    int from,
    int size,
    String scroll,
  }) async {
    final request = KuzzleRequest(
      controller: name,
      action: 'searchSpecifications',
      body: query,
      from: from,
      size: size,
      scroll: scroll,
    );
    final response = await kuzzle.query(request);

    return SpecificationSearchResult(
      kuzzle, 
      request: request, 
      response: response);
  }

  /// Empties a [collection] by removing all its documents,
  /// while keeping any associated mapping
  Future<Map<String, dynamic>> truncate(String index, String collection) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'truncate',
      index: index,
      collection: collection,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a data [collection] data [mappings].
  /// TODO: check if mappings/settings are optional or both are necessary
  ///
  /// **Warning**: While updating the collection settings, the collection will
  /// be closed until the new configuration has been applied.
  Future<Map<String, dynamic>> update(
    String index,
    String collection,
    Map<String, dynamic> mappings,
    Map<String, dynamic> settings,
  ) async {
    final body = <String, dynamic>{};

    if (mappings != null) {
      body['mappings'] = mappings;
    }

    if (settings != null) {
      body['settings'] = settings;
    }

    final response = await kuzzle.query(KuzzleRequest(
      index: index,
      collection: collection,
      controller: name,
      action: 'update',
      body: body,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates a data [collection] data [mapping].
  @Deprecated('Deprecated since 2.1.0 and will be removed. Please use Update instead')
  Future<Map<String, dynamic>> updateMapping(
    String index,
    String collection,
    Map<String, dynamic> mapping,
  ) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateMapping',
      index: index,
      collection: collection,
      body: mapping,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// You can specify validation [specifications] in order to enforce your own
  /// rules over documents and real-time messages. Whenever a document is
  /// stored or updated, or a message is published, Kuzzle applies these
  /// specifications to check if the new data complies to the defined rules.
  /// If not, the document or message will be rejected and the request
  /// will return an error message.
  ///
  /// The updateSpecifications method allows you to create or update the
  /// validation specifications for one or more index/collection pairs.
  ///
  /// When the validation specification is not formatted correctly,
  /// a detailed error message is returned to help you to debug.
  Future<Map<String, dynamic>> updateSpecifications(
    String index,
    String collection,
    Map<String, dynamic> specifications,
  ) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      index: index,
      collection: collection,
      action: 'updateSpecifications',
      body: specifications,
    ));

    final result = response.result as Map<String, dynamic>;

    if (result['fields'] is Map) {
      return result;
    }

    throw BadResponseFormatError(
      response.error?.id,
      'UpdateSpecifications: bad response format',
      response,
    );
  }

  /// The validateSpecifications method checks
  /// if a validation specification is well formatted.
  /// It does not store nor modify the existing specification.
  Future<bool> validateSpecifications(
    String index,
    String collection,
    Map<String, dynamic> specifications,
  ) async {
    final response = await kuzzle.query(KuzzleRequest(
        controller: name,
        collection: collection,
        index: index,
        action: 'validateSpecifications',
        body: specifications));

    return (response.result as Map<String, dynamic>)['valid'] as bool;
  }
}
