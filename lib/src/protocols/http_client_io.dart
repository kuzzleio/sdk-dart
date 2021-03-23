import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

BaseClient createHttpClient({bool acceptBadCertificate = false}) {
  print('io');
  final client = HttpClient()
    ..badCertificateCallback = ((cert, host, port) => acceptBadCertificate);
  return IOClient(client);
}
