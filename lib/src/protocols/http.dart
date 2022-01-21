import 'dart:convert';

import 'package:http/http.dart';
import 'package:kuzzle/src/kuzzle/request.dart';
import 'package:kuzzle/src/kuzzle/response.dart';
import 'package:kuzzle/src/protocols/abstract.dart';
import 'package:kuzzle/src/protocols/http_client_io.dart'
    if (dart.library.html) 'package:kuzzle/src/protocols/http_client_browser.dart';

import 'events.dart';

class HttpProtocol extends KuzzleProtocol {
  HttpProtocol(Uri uri, {bool acceptBadCertificate = false}) : super(uri) {
    _ioClient = createHttpClient(acceptBadCertificate: acceptBadCertificate);
  }

  late BaseClient _ioClient;

  @override
  Future<void> protocolConnect() async {
    if (connectionAborted) {
      return;
    }

    final res = await _ioClient.post(Uri.parse('${uri.toString()}/_query'));
    if (res.statusCode == 401 || res.statusCode == 403) {
      throw Exception('You must have permission on the _query route.');
    }
  }

  @override
  Future<void> send(KuzzleRequest request) async {
    final headers = {'Content-Type': 'application/json'};

    if (request.jwt != null) {
      headers['Authorization'] = 'Bearer ${request.jwt}';
    }

    if (request.volatile != null) {
      headers['x-kuzzle-volatile'] = jsonEncode(request.volatile);
    }

    final res = await _ioClient.post(
      Uri.parse('${uri.toString()}/_query'),
      headers: headers,
      body: jsonEncode(request),
    );

    emit(request.requestId!, [
      KuzzleResponse.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>)
    ]);
  }
}
