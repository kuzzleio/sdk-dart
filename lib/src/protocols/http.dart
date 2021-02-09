import 'dart:convert';

import 'package:kuzzle/src/kuzzle/request.dart';
import 'package:kuzzle/src/protocols/abstract.dart';
import 'package:http/http.dart' as http;
import 'package:kuzzle/src/protocols/routes.dart';

class HttpProtocol extends KuzzleProtocol {
  HttpProtocol(Uri uri, {Map<String, dynamic> customRoutes = const {}})
      : super(uri) {
    customRoutes.forEach((key, value) {
      _routes[key] = value;
    });
  }

  Map<String, dynamic> _routes = {};

  @override
  Future<void> connect() async {
    await super.connect();

    final res = await http.get('${uri.toString()}/_publicApi');
    if (res.statusCode == 401 || res.statusCode == 403) {
      _routes = routes;
    } else {
      final decoded = json.decode(res.body);
      final map = decoded['result'] as Map;
      // print(map['auth']);
      map.forEach((controller, value) {
        _routes[controller.toString()] = {};
        final valueAsMap = value as Map;
        valueAsMap.forEach((action, value) {
          if (value['http']?.length == 1) {
            _routes[controller][action] = value['http'][0];
          } else if (value['http'] != null) {
            // We need this ugly fix because the document:search route can also
            // be accessed in GET with this url: "/:index/:collection"
            // But to send a query,
            // we need to pass it in the body so we need POST
            // so we can change the verb but then POST on "/:index/:collection"
            // is the collection:update method (document:search is "/:index/:collection/_search")
            if (controller == 'document' && action == 'search') {
              _routes[controller][action] = _getPostRoute(value['http']);
            } else {
              _routes[controller][action] = _getRightRoute(value['http']);
            }
          }
        });
      });
    }
  }

  dynamic _getPostRoute(routes) =>
      routes[0]['verb'] == 'POST' ? routes[0] : routes[1];

  dynamic _getRightRoute(routes) {
    dynamic shortestRoute = routes[0], getRoute;
    var minLength = routes[0]['url'].length as int;
    var sameLength = true;

    for (final route in routes) {
      final url = route['url'] as String;
      if (url.length != minLength) {
        sameLength = false;
      }

      if (url.length < minLength) {
        shortestRoute = route;
        minLength = url.length;
      }

      if (route['verb'] == 'GET') {
        getRoute = route;
      }
    }

    // with same URL size, we keep the GET route
    // with differents URL sizes, we keep the shortest because URL params
    // will be in the query string
    return sameLength ? getRoute : shortestRoute;
  }

  @override
  void send(KuzzleRequest request) {
    // TODO: implement send
  }
}
