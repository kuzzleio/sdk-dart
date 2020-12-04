import 'package:meta/meta.dart';

import '../kuzzle.dart';
import '../kuzzle/errors.dart';
import '../kuzzle/request.dart';

import '../search_result/search-result.dart';

import 'abstract.dart';

class DocumentController extends KuzzleController {
  DocumentController(Kuzzle kuzzle) : super(kuzzle, name: 'document');

  /// Counts documents in a data [collection].
  ///
  /// A [query] can be provided to alter the count result,
  /// otherwise returns the total number of documents in the data collection.
  Future<int> count(
    String index,
    String collection,
    {Map<String, dynamic> query}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'count',
      index: index,
      collection: collection,
      body: query,
    ));

    return response.result['count'] as int;
  }

  /// Creates a new document in the persistent data storage.
  Future<Map<String, dynamic>> create(
    String index,
    String collection,
    Map<String, dynamic> document, {
    String id,
    bool waitForRefresh = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'create',
      index: index,
      collection: collection,
      uid: id,
      body: document,
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Creates a new document in the persistent data storage,
  /// or replaces its content if it already exists.
  Future<Map<String, dynamic>> createOrReplace(
    String index,
    String collection,
    String id,
    Map<String, dynamic> document, {
    bool waitForRefresh = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'createOrReplace',
      index: index,
      collection: collection,
      uid: id,
      body: document,
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes a document.
  Future<void> delete(
    String index,
    String collection,
    String id, {
    bool waitForRefresh = false,
  }) async {
    await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'delete',
      index: index,
      collection: collection,
      uid: id,
      waitForRefresh: waitForRefresh,
    ));
  }

  /// Deletes documents matching the provided search query.
  Future<List<String>> deleteByQuery(
    String index,
    String collection,
    Map<String, dynamic> query, {
    bool waitForRefresh = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'deleteByQuery',
      index: index,
      collection: collection,
      body: query,
      waitForRefresh: waitForRefresh,
    ));

    return List<String>.from(
      response.result['ids'] as List<dynamic>
    ) as List<String>;
  }

  /// Check if a document exists
  Future<bool> exists(String index, String collection, String id) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'exists',
      index: index,
      collection: collection,
      uid: id,
    ));

    if (response.result is bool) {
      return response.result as bool;
    }

    throw BadResponseFormatError(
      response.error?.id,
      '$name.exists: bad response format', 
      response
    );
  }

  /// Get a document
  Future<Map<String, dynamic>> get(
    String index,
    String collection,
    String id,
  ) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'get',
      index: index,
      collection: collection,
      uid: id,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Creates multiple documents.
  Future<Map<String, dynamic>> mCreate(
      String index, String collection, List<Map<String, dynamic>> documents,
      {bool waitForRefresh = false}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'mCreate',
      index: index,
      collection: collection,
      body: <String, dynamic>{'documents': documents},
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Creates or replaces multiple documents.
  Future<Map<String, dynamic>> mCreateOrReplace(
    String index,
    String collection,
    List<Map<String, dynamic>> documents, {
    bool waitForRefresh = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'mCreateOrReplace',
      index: index,
      collection: collection,
      body: <String, dynamic>{'documents': documents},
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Deletes multiple documents.
  Future<Map<String, dynamic>> mDelete(
    String index,
    String collection,
    List<String> ids, {
    bool waitForRefresh = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'mDelete',
      index: index,
      collection: collection,
      body: <String, dynamic>{'ids': ids},
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Gets multiple documents.
  Future<Map<String, dynamic>> mGet(
    String index,
    String collection,
    List<String> ids,
  ) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'mGet',
      index: index,
      collection: collection,
      body: <String, dynamic>{'ids': ids},
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Replaces multiple documents.
  Future<Map<String, dynamic>> mReplace(
    String index,
    String collection,
    List<Map<String, dynamic>> documents, {
    bool waitForRefresh = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'mReplace',
      index: index,
      collection: collection,
      body: <String, dynamic>{'documents': documents},
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates multiple documents.
  Future<Map<String, dynamic>> mUpdate(
      String index, String collection, List<Map<String, dynamic>> documents,
      {bool waitForRefresh = false, int retryOnConflict}) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'mUpdate',
      index: index,
      collection: collection,
      body: <String, dynamic>{'documents': documents},
      waitForRefresh: waitForRefresh,
      retryOnConflict: retryOnConflict,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Replaces the content of an existing document.
  Future<Map<String, dynamic>> replace(
    String index,
    String collection,
    String id,
    Map<String, dynamic> document, {
    bool waitForRefresh = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'replace',
      index: index,
      collection: collection,
      uid: id,
      body: document,
      waitForRefresh: waitForRefresh,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Moves a search cursor forward.
  ///
  /// A search cursor is created by a search API call,
  /// with a scroll value provided.
  ///
  /// Results returned by a scroll request reflect the state of the index at
  /// the time of the initial search request, like a fixed snapshot.
  /// Subsequent changes to documents do not affect the scroll results.
  Future<Map<String, dynamic>> scroll(
    String index,
    String collection,
    String scrollId, {
    String scroll,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'scroll',
      index: index,
      collection: collection,
      scrollId: scrollId,
      scroll: scroll,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Searches documents.
  ///
  /// There is a limit to how many documents
  /// can be returned by a single search query.
  ///
  /// That limit is by default set at 10000 documents,
  /// and you can't get over it even with the from and size pagination options.
  ///
  /// To handle larger result sets, you have to either create a cursor
  /// by providing a value to the scroll option or,
  /// if you sort the results, by using the Elasticsearch search_after command.
  Future<SearchResult> search(
    String index,
    String collection, {
    Map<String, dynamic> query,
    int from,
    int size,
    String scroll,
  }) async {
    final request = KuzzleRequest(
      action: 'search',
      collection: collection,
      controller: name,
      index: index,
      body: query,
      from: from,
      size: size,
      scroll: scroll,
    );
    final response = await kuzzle.query(request);

    return SearchResult(kuzzle, request: request, response: response);
  }

  /// ####Updates a document content.
  ///
  /// **[index]**: index name \\\
  /// **[collection]**: collection name \\\
  /// **[uid]**: unique identifier of the document to update \\\
  /// **[document]**: document as `Map<String, dynamic>` \\\
  ///
  ///
  /// Optional
  ///
  /// **[refresh]**: if set to wait_for, Kuzzle will not respond
  /// until the update is indexed \\\
  /// **[retryOnConflict]**: conflicts may occur if the same document gets updated multiple times within a short timespan, in a database cluster. You can set the retryOnConflict optional argument (with a retry count), to tell Kuzzle to retry the failing updates the specified amount of times before rejecting the request with an error. \\\
  /// **[source]**: if set to true Kuzzle will return the updated document body in the response \\\
  Future<Map<String, dynamic>> update(
    String index,
    String collection,
    String id,
    Map<String, dynamic> document, {
    bool waitForRefresh = false,
    int retryOnConflict,
    bool source,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'update',
      index: index,
      collection: collection,
      uid: id,
      body: document,
      waitForRefresh: waitForRefresh,
      source: source,
      retryOnConflict: retryOnConflict,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Updates documents matching the provided search query.
  /// Documents updated that way trigger real-time notifications.
  ///
  /// ---
  /// Limitations
  /// ---
  ///
  /// The request fails if the number of documents returned by the search
  /// query exceeds the documentsWriteCount server configuration (see the
  /// Configuring Kuzzle guide).
  ///
  /// update a greater number of documents, either change the server
  /// configuration, or split the search query.
  ///
  Future<Map<String, dynamic>> updateByQuery(
    String index,
    String collection,
    {
    @required Map<String, dynamic> searchQuery,
    @required Map<String, dynamic> changes,
    bool waitForRefresh = false,
    bool source = false,
  }) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'updateByQuery',
      index: index,
      collection: collection,
      body: {
        'query': searchQuery,
        'changes': changes
      },
      waitForRefresh: waitForRefresh,
      source: source,
    ));

    return response.result as Map<String, dynamic>;
  }

  /// Validates data against existing validation rules.
  ///
  /// Documents are always valid if no validation rules are defined
  /// on the provided index and collection.
  ///
  /// This request does not store the document.
  Future<bool> validate(
    String index,
    String collection,
    Map<String, dynamic> document,
  ) async {
    final response = await kuzzle.query(KuzzleRequest(
      controller: name,
      action: 'validate',
      index: index,
      collection: collection,
      body: document,
    ));

    return (response.result as Map<String, dynamic>)['valid'] as bool;
  }
}
