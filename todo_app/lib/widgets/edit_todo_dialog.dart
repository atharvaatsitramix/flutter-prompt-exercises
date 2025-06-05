import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class EditTodoDialog extends StatefulWidget {
  final Todo todo;

  const EditTodoDialog({
    super.key,
    required this.todo,
  });

  @override
  State<EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _contentController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.todo.contents);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _contentController,
          decoration: const InputDecoration(
            labelText: 'Todo content',
            hintText: 'Enter your todo...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          minLines: 1,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter todo content';
            }
            return null;
          },
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _updateTodo,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _updateTodo() async {
    if (!_formKey.currentState!.validate()) return;

    final newContent = _contentController.text.trim();
    if (newContent == widget.todo.contents) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isLoading = true);

    try {
      await context.read<TodoProvider>().updateTodo(widget.todo.id, newContent);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update todo: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
} 