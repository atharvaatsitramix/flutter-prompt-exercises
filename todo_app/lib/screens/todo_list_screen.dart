import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';
import '../widgets/add_todo_dialog.dart';
import 'settings_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Todos',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.isLoading && todoProvider.todos.isEmpty) {
            return Center(
              child: SpinKitFadingCircle(
                color: Theme.of(context).colorScheme.primary,
                size: 50.0,
              ),
            );
          }

          if (todoProvider.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      todoProvider.error!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      todoProvider.clearError();
                      todoProvider.loadTodos();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (todoProvider.todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No todos yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first todo',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => todoProvider.loadTodos(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: todoProvider.todos.length,
              itemBuilder: (context, index) {
                final todo = todoProvider.todos[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TodoItem(todo: todo),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTodoDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Todo'),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
  }
} 