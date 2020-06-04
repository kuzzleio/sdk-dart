final List<Map<String, dynamic>> documents = [];

for (var i = 0; i < 100; i++) {
  documents.add({ '_id': 'suv_no${i}', 'body': { 'category': 'suv' } });
}

await kuzzle.document.mCreate('nyc-open-data', 'yellow-taxi', documents,
  waitForRefresh: true
);

var res = await kuzzle.document.search(
  'nyc-open-data',
  'yellow-taxi',
  query: { 'query': { 'match': { 'category': 'suv' } } },
  from: 1, size: 5);

// Fetch the matched items by advancing through the result pages
final result = [];

while (res != null) {
  result.addAll(res.hits);
  res = await res.next();
}