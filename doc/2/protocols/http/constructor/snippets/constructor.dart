final proto = HttpProtocol(
  Uri(
    scheme: 'http',
    host: 'kuzzle',
    port: 7512
  ),
);
final kuzzle = Kuzzle(proto);
