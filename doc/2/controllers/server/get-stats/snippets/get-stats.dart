DateTime startTime = new DateTime.fromMillisecondsSinceEpoch(1234567890101);
DateTime stopTime = new DateTime.fromMillisecondsSinceEpoch(1541426610304);

final result = await kuzzle
  .server
  .getStats(startTime, stopTime);