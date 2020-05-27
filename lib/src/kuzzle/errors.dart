import 'response.dart';

class KuzzleError extends Error {
  KuzzleError([this.id, this.message, this.status, StackTrace _stack])
      : stack = _stack ?? StackTrace.current;

  factory KuzzleError.fromJson(Map<String, dynamic> json) =>
      KuzzleError(json['error']['id'] as String, 
      json['error']['message'] as String, 
      json['status'] as int
  );

  final String id; 
  final int status;
  final String message;
  final StackTrace stack;

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
  };

  @override
  String toString() => 'KuzzleError[$status][$message]';
}

class BadResponseFormatError extends KuzzleError {
  BadResponseFormatError(String id, String message, this.response)
    : super(id, message, 400);

  final KuzzleResponse response;
}
