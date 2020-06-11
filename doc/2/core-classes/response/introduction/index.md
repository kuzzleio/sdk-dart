---
code: false
type: page
title: Introduction
description: KuzzleResponse object description
order: 0
---

## KuzzleResponse

`KuzzleResponse` is a **serializable** class representing a raw Kuzzle response.


## Properties

| Property | Type | Description |
|--- |--- |--- |
| `action` | <pre>String</pre> | Executed Kuzzle API controller's action |
| `collection` | <pre>String</pre> | Impacted collection |
| `controller` | <pre>String</pre> | Executed Kuzzle API controller |
| `error` | <pre>[KuzzleError](/sdk/dart/2/core-classes/kuzzle-error)</pre> | Error object (null if the request finished successfully) |
| `index` | <pre>String</pre> | Impacted index |
| `protocol` | <pre>String</pre> | Network protocol at the origin of the real-time notification |
| `requestId` | <pre>String</pre> | Request unique identifier |
| `result` | <pre>dynamic</pre> | Response payload (depends on the executed API action) |
| `room` | <pre>String</pre> | Room identifier (realtime only) |
| `scope` | <pre>String</pre> | Document scope ("in" or "out", realtime only) |
| `state` | <pre>String</pre> | Document state (realtime only) |
| `status` | <pre>int</pre> | Response status, following HTTP status codes |
| `timestamp` | <pre>double</pre> | Notification timestamp (UTC) |
| `users` | <pre>String</pre> | Docuent users ("all", "in", "out", "none")
| `volatile` | <pre>Map<String, dynamic></pre> | Volatile data |
