import 'dart:convert';

import 'package:http/http.dart';
import 'package:kuzzle/src/kuzzle/request.dart';
import 'package:kuzzle/src/kuzzle/response.dart';
import 'package:kuzzle/src/protocols/abstract.dart';
import 'package:kuzzle/src/protocols/http_client_io.dart'
    if (dart.library.html) 'package:kuzzle/src/protocols/http_client_browser.dart';

class HttpProtocol extends KuzzleProtocol {
  HttpProtocol(Uri uri, {bool acceptBadCertificate = false}) : super(uri) {
    _ioClient = createHttpClient(acceptBadCertificate: acceptBadCertificate);
  }

  BaseClient _ioClient;

  @override
  Future<void> connect() async {
    await super.connect();

    final res = await _ioClient.get('${uri.toString()}/_query');
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

    final res = await _ioClient.post(
      '${uri.toString()}/_query',
      headers: headers,
      body: jsonEncode(request),
    );
    if (res.statusCode != 200) {
      return Future.error(res);
    }
    return Future.value(
      KuzzleResponse.fromJson(jsonDecode(res.body) as Map<String, dynamic>),
    );
  }
}
