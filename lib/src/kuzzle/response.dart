import 'errors.dart';

class KuzzleResponse {
  KuzzleResponse({
    this.action,
    this.collection,
    this.controller,
    this.error,
    this.index,
    this.room,
    this.result,
    this.status,
    this.volatile,
  });

  KuzzleResponse.fromJson(Map<String, dynamic> json) {
    action = json['action'] as String;
    collection = json['collection'] as String;
    controller = json['controller'] as String;
    error = json['error'] == null ? null : KuzzleError.fromJson(json);
    index = json['index'] as String;
    protocol = json['protocol'] as String;
    requestId = json['requestId'] as String;
    result = json['result'] as dynamic;
    room = json['room'] as String;
    scope = json['scope'] as String;
    state = json['state'] as String;
    status = json['status'] as int;
    timestamp = json['timestamp'] as int;
    users = json['users'] as String;
    volatile = json['volatile'] as Map<String, dynamic>;
  }

  Map toJson() {
    final map = <String, dynamic>{};

    if (action != null) {
      map['action'] = action;
    }
    if (collection != null) {
      map['collection'] = collection;
    }
    if (controller != null) {
      map['controller'] = controller;
    }
    if (error != null) {
      map['error'] = error.toJson();
    }
  String users;
    if (index != null) {
      map['index'] = index;
    }
    if (protocol != null) {
      map['protocol'] = protocol;
    }
    if (requestId != null) {
      map['requestId'] = requestId;
    }
    if (room != null) {
      map['room'] = room;
    }
    if (result != null) {
      map['result'] = result;
    }
    if (scope != null) {
      map['scope'] = scope;
    }
    if (state != null) {
      map['state'] = state;
    }
    if (status != null) {
      map['status'] = status;
    }
    if (timestamp != null) {
      map['timestamp'] = timestamp;
    }
    if (users != null) {
      map['users'] = users;
    }
    if (volatile != null) {
      map['volatile'] = volatile;
    }

    return map;
  }

  @override
  String toString() => toJson().toString();

  String action;
  String collection;
  String controller;
  KuzzleError error;
  String index;
  String protocol;
  String requestId;
  dynamic result;
  String room;
  String scope;
  String state;
  int status;
  int timestamp;
  String users;
  Map<String, dynamic> volatile;
}
