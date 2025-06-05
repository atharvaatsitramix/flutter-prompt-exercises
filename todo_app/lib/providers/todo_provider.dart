import 'package:flutter/foundation.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoProvider with ChangeNotifier {
  final TodoService _todoService = TodoService();
  List<Todo> _todos = [];
  bool _isLoading = false;
  String? _error;

  List<Todo> get todos => List.unmodifiable(_todos);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;

  // Load all todos
  Future<void> loadTodos() async {
    _setLoading(true);
    _clearError();
    
    try {
      _todos = await _todoService.getTodos();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Add a new todo
  Future<void> addTodo(String contents) async {
    if (contents.trim().isEmpty) {
      _setError('Todo content cannot be empty');
      return;
    }

    _setLoading(true);
    _clearError();
    
    try {
      final newTodo = await _todoService.createTodo(contents);
      _todos.add(newTodo);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Update an existing todo
  Future<void> updateTodo(int id, String contents) async {
    if (contents.trim().isEmpty) {
      _setError('Todo content cannot be empty');
      return;
    }

    _setLoading(true);
    _clearError();
    
    try {
      final updatedTodo = await _todoService.updateTodo(id, contents);
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index] = updatedTodo;
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Delete a todo
  Future<void> deleteTodo(int id) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _todoService.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }
} 