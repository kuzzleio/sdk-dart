---
code: true
type: page
title: next
description: RoleSearchResult next method
order: 200
---

# next

Advances through the search results and returns the next page of items.

## Arguments

```dart
Future<List<dynamic>> next()
```

## Returns

Returns a `RoleSearchResult` object, or `null` if no more pages are available.

## Pagination strategie

The `next` method can work with the following strategie.

### Strategy: from / size

If the initial search contains `from` and `size` parameters, the `next` method retrieves the next page of result by incrementing the `from` offset.

Because this method does not freeze the search results between two calls, there can be missing or duplicated documents between two result pages.

It's the fastest pagination method available, but also the less consistent, and it is not possible to retrieve more than 10000 items using it.  
Above that limit, any call to `next` throws an Exception.

<<< ./snippets/fromsize.dart
