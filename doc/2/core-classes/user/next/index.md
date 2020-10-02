---
code: true
type: page
title: next
description: UserSearchResult next method
order: 200
---

# next

Advances through the search results and returns the next page of items.

## Arguments

```dart
Future<List<dynamic>> next()
```

## Returns

Returns a `UserSearchResult` object, or `null` if no more pages are available.

## Pagination strategies

Depending on the arguments given to the initial search, the `next` method will pick one of the following strategies, by decreasing order of priority.

### Strategy: scroll cursor

If the original search query is given a `scroll` parameter, the `next` method uses a cursor to paginate results.

The results from a scroll request are frozen, and reflect the state of the index at the time the initial `search` request.  
For that reason, this method is guaranteed to return consistent results, even if documents are updated or deleted in the database between two pages retrieval.

This is the most consistent way to paginate results, however, this comes at a higher computing cost for the server.

::: warning
When using a cursor with the `scroll` option, Elasticsearch has to duplicate the transaction log to keep the same result during the entire scroll session.  
It can lead to memory leaks if a scroll duration too great is provided, or if too many scroll sessions are open simultaneously.  
:::

::: info
<SinceBadge version="Kuzzle 2.2.0"/>
You can restrict the scroll session maximum duration under the `services.storage.maxScrollDuration` configuration key.
:::

<<< ./snippets/scroll.dart

### Strategy: sort / size

If the initial search contains `sort` and `size` parameters, the `next` method retrieves the next page of results following the sort order, the last item of the current page acting as a live cursor.

To avoid too many duplicates, it is advised to provide a sort combination that will always identify one item only. The recommended way is to use the field `_uid` which is certain to contain one unique value for each document.

Because this method does not freeze the search results between two calls, there can be missing or duplicated documents between two result pages.

This method efficiently mitigates the costs of scroll searches, but returns less consistent results: it's a middle ground, ideal for real-time search requests.

### Strategy: from / size

If the initial search contains `from` and `size` parameters, the `next` method retrieves the next page of result by incrementing the `from` offset.

Because this method does not freeze the search results between two calls, there can be missing or duplicated documents between two result pages.

It's the fastest pagination method available, but also the less consistent, and it is not possible to retrieve more than 10000 items using it.  
Above that limit, any call to `next` throws an Exception.

<<< ./snippets/fromsize.dart
