import 'dart:developer';
import 'package:kuzzle/src/kuzzle/response.dart';

class DeprecationHandler {
  
  DeprecationHandler({ this.deprecationWarning });

  final bool deprecationWarning;

  KuzzleResponse logDeprecation(KuzzleResponse response) {
    if(deprecationWarning && response.deprecations.isNotEmpty) {
      for (var index = 0; index < response.deprecations.length; index++) {
        log(
          '${response.action}: ${response.deprecations[index].message}',
          name: 'Deprecation Warning',
          level: 900 // Warning
        );
      }
    }
    return response;
  }
}

class Deprecation {
  Deprecation(this.message, this.version);

  factory Deprecation.fromJson(Map<String, dynamic> json) => 
    Deprecation(json['message'] as String, json['version'] as String);

  static List<Deprecation> fromJsonList(Map<String, dynamic> json) {
    if (json['deprecations'] == null || json['deprecations'] is! List<Object>) {
      return [];
    }
    final list = <Deprecation>[];
    for (var index = 0; index < (json['deprecations'].length as int); index++) {
      list.add(
        Deprecation.fromJson(
          json['deprecations'][index] as Map<String, dynamic>
        )
      );
    }
    return list;
  }

  final String message;
  final String version;

  Map<String, dynamic> toJson() => {
    'message': message,
    'version': version,
  };

  static Map<String, dynamic> toJsonList(List<Deprecation> list) {
    final jsonList = <Map<String, dynamic>>[]; 
    for (var index = 0; index < list.length; index++) {
      jsonList.add(list[index].toJson());
    }
    return {
      'deprecations': jsonList
    };
  }

}