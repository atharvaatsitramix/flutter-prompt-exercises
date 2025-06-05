import 'todo.dart';

class ApiResponse {
  final String message;
  final List<Todo> data;

  ApiResponse({
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => Todo.fromJson(item))
          .toList(),
    );
  }
} 