import 'dart:developer';

class Deprecation {
  final bool deprecationWarning;

  Deprecation(this.deprecationWarning);

  Object logDeprecation(Object response) {
    if(this.deprecationWarning && response.deprecations?.length > 0) {
      for (var index = 0; index < response.deprecations.length; index++) {
        log('Deprecation Warning: ${response.deprecations[index].message}');
      }
    }
    return response;
  }
}