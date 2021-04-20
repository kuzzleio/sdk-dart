import 'dart:convert';
import 'dart:developer';
import 'package:kuzzle/src/kuzzle/response.dart';

class DeprecationHandler {
  
  DeprecationHandler({ this.deprecationWarning = true });

  final bool deprecationWarning;

  KuzzleResponse logDeprecation(KuzzleResponse response) {
    if (deprecationWarning && response.deprecations.isNotEmpty) {
      for (final deprecation in response.deprecations) {
        log(
          '${response.action}: ${deprecation.message}',
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
    for (final deprecation in json['deprecations']) {
      list.add(
        Deprecation.fromJson(
          deprecation as Map<String, dynamic>
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

  static String toJsonList(List<Deprecation> list) {
    final jsonList = <Map<String, dynamic>>[]; 
    for (final deprecation in list) {
      jsonList.add(deprecation.toJson());
    }
    return jsonEncode(jsonList);
  }

}
