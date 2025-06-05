import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/todo.dart';
import '../models/api_response.dart';

class TodoService {
  static const String baseUrl = 'http://localhost:8080';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // Get all todos
  Future<List<Todo>> getTodos() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/todos'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(json.decode(response.body));
        return apiResponse.data;
      } else {
        throw HttpException('Failed to load todos: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Network error: $e');
    }
  }

  // Create a new todo
  Future<Todo> createTodo(String contents) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/todos'),
        headers: headers,
        body: json.encode({'contents': contents}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiResponse = ApiResponse.fromJson(json.decode(response.body));
        return apiResponse.data.first;
      } else {
        throw HttpException('Failed to create todo: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Network error: $e');
    }
  }

  // Update an existing todo
  Future<Todo> updateTodo(int id, String contents) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/todos/$id'),
        headers: headers,
        body: json.encode({'contents': contents}),
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(json.decode(response.body));
        return apiResponse.data.first;
      } else {
        throw HttpException('Failed to update todo: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Network error: $e');
    }
  }

  // Delete a todo
  Future<void> deleteTodo(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/todos/$id'),
        headers: headers,
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw HttpException('Failed to delete todo: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Network error: $e');
    }
  }
} 