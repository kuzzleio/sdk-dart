---
code: true
type: page
title: updateMapping
description: Update the collection mapping
---

# updateMapping

<SinceBadge version="1.7.1" />

You can define the collection [dynamic mapping policy](/core/2/guides/main-concepts/data-storage#mappings-dynamic-policy) by setting the `dynamic` field to the desired value.

You can define [collection additional metadata](/core/2/guides/main-concepts/data-storage#mappings-metadata) within the `_meta` root field.

<br/>

```dart
Future<Map<String, dynamic>> updateMapping(
    String index,
    String collection,
    Map<String, dynamic> mapping,
  )
```

<br/>

| Arguments    | Type              | Description                                                                                                                                                                   |
| ------------ | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `index`      | <pre>String</pre> | Index name                                                                                                                                                                    |
| `collection` | <pre>String</pre> | Collection name                                                                                                                                                               |
| `mapping`    | <pre>Map<String, dynamic></pre> | Describes the collection mapping  |

### mapping

An object representing the collection data mapping.

This object must have a root field `properties` that contain the mapping definition:

More informations about database mappings [here](/core/2/guides/main-concepts/data-storage).

## Returns

Returns a `Map<String, dynamic>`

## Usage

<<< ./snippets/update-mapping.dart
