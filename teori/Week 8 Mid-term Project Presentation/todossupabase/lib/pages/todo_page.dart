import 'package:flutter/material.dart';

import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoPage extends StatefulWidget {
  final TodoController? controller;

  const TodoPage({super.key, this.controller});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final TodoController _controller;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TodoController(TodoApiService());
    _controller.onStateChanged = _refreshUi;
    _loadInitialData();
  }

  void _refreshUi() {
    if (mounted) setState(() {});
  }

  Future<void> _loadInitialData() async {
    await _controller.loadTodos();
    _refreshUi();
  }

  Future<void> _onRefresh() async {
    await _controller.loadTodos();
    _refreshUi();
  }

  Future<void> _onAddTodo(String name, String description) async {
    await _controller.addTodo(name, description);
    _refreshUi();
  }

  Future<void> _onToggle(TodoModel todo) async {
    await _controller.toggleTodoDone(todo);
    _refreshUi();
  }

  Future<void> _onDelete(TodoModel todo) async {
    await _controller.deleteTodo(todo);
    _refreshUi();
  }

  @override
  void dispose() {
    _controller.onStateChanged = null;
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _showAddTodoDialog() async {
    _nameController.clear();
    _descriptionController.clear();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final description = _descriptionController.text.trim();

                if (name.isEmpty || description.isEmpty) {
                  return;
                }

                await _onAddTodo(name, description);
                if (!context.mounted) return;
                Navigator.of(context).pop(); // close dialog after success
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showItemOptionsDialog(TodoModel todo) async {
    final isCurrentlyDone = todo.isDone;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Todo Options'),
          content: Text(
            'Choose an action for the todo:\n"${todo.name}"',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // close dialog first
                await _onToggle(todo); // toggle status
              },
              child: Text(
                isCurrentlyDone ? 'Mark as not done' : 'Mark as done',
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // close dialog
                await _onDelete(todo); // delete todo
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = _controller.todos;
    final isLoading = _controller.isLoading;
    final errorMessage = _controller.errorMessage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todos API Supabase'),
      ),
      body: Column(
        children: [
          if (isLoading) const LinearProgressIndicator(),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: todos.isEmpty && !isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            errorMessage != null
                                ? Icons.cloud_off_outlined
                                : Icons.checklist_rounded,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            errorMessage != null
                                ? 'Gagal memuat data'
                                : 'Belum ada todo. Tambahkan todo pertamamu!',
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (errorMessage != null) ...[
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: _onRefresh,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Coba Lagi'),
                            ),
                          ],
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        final textStyle = TextStyle(
                          decoration: todo.isDone
                               ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        );

                        return ListTile(
                          leading: IconButton(
                            icon: Icon(
                              todo.isDone
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: todo.isDone ? Colors.green : Colors.grey,
                            ),
                            onPressed: () => _onToggle(todo),
                          ),
                          title: Text(
                            todo.name,
                            style: textStyle,
                          ),
                          subtitle: Text(
                            todo.description,
                            style: textStyle,
                          ),
                          onLongPress: () => _showItemOptionsDialog(todo),
                          onTap: () => _showItemOptionsDialog(todo),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
