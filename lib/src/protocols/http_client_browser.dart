import 'package:http/browser_client.dart';
import 'package:http/http.dart';

BaseClient createHttpClient({bool acceptBadCertificate = false}) {
  return BrowserClient();
}
