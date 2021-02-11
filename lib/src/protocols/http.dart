import 'dart:convert';

import 'package:kuzzle/src/kuzzle/request.dart';
import 'package:kuzzle/src/kuzzle/response.dart';
import 'package:kuzzle/src/protocols/abstract.dart';
import 'package:http/http.dart' as http;

class HttpProtocol extends KuzzleProtocol {
  HttpProtocol(Uri uri) : super(uri);

  @override
  Future<void> connect() async {
    await super.connect();

    final res = await http.get('${uri.toString()}/_query');
    if (res.statusCode == 401 || res.statusCode == 403) {
      return Future.error('You must have permission on the _query route.');
    }
    clientConnected();
    return Future.value();
  }

  @override
  Future<KuzzleResponse> send(KuzzleRequest request) async {
    final headers = {'Content-Type': 'application/json'};

    if (request.jwt != null) {
      headers['Authorization'] = 'Bearer ${request.jwt}';
    }

    if (request.volatile != null) {
      headers['x-kuzzle-volatile'] = jsonEncode(request.volatile);
    }

    final res = await http.post(
      '${uri.toString()}/_query',
      headers: headers,
      body: jsonEncode(request),
    );
    return Future.value(
      KuzzleResponse.fromJson(jsonDecode(res.body) as Map<String, dynamic>),
    );
  }
}
