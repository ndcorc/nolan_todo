import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nolan_todo/models/todo.dart';
import 'package:nolan_todo/providers/todos.dart';
import 'package:uuid/uuid.dart';

class TodoTile extends HookConsumerWidget {
  final Todo todo;
  const TodoTile({required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosCtrl = ref.watch(todosProvider.notifier);
    return Card(
      child: ListTile(
        title: Text(todo.description),
        leading: IconButton(
          icon: todo.completed
              ? const Icon(Icons.check_box, color: Colors.green)
              : const Icon(Icons.check_box_outline_blank),
          onPressed: () {
            todosCtrl.toggle(todo.id);
          },
        ),
        subtitle: Text(todo.id),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () => todosCtrl.addTodo(
                Todo(
                  id: const Uuid().v4(),
                  description: todo.description,
                  completed: false,
                ),
              ),
              child: const Text('Duplicate'),
            ),
            PopupMenuItem(
              onTap: () => todosCtrl.removeTodo(todo.id),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
