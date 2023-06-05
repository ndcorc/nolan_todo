import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nolan_todo/models/todo.dart';
import 'package:nolan_todo/providers/sort.dart';
import 'package:nolan_todo/providers/todos.dart';
import 'package:nolan_todo/widgets/todo_tile.dart';
import 'package:uuid/uuid.dart';

class SimpleTodo extends HookConsumerWidget {
  const SimpleTodo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textCtrl = useTextEditingController();
    final asyncTodos = ref.watch(todosProvider);
    final sortOrder = ref.watch(sortProvider);
    final sortCtrl = ref.watch(sortProvider.notifier);

    final handleChangeSort = () => {
          sortCtrl.state =
              sortOrder == SortOrder.ASC ? SortOrder.DESC : SortOrder.ASC,
        };

    return asyncTodos.when(
      data: (todoList) => Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                'SimpleTodo',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextField(
                controller: textCtrl,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter New Todo',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () => handleChangeSort(),
                  )
                ],
              ),
              Text(
                'Todos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, int index) => TodoTile(
                    todo: todoList[index],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ref.read(todosProvider.notifier).addTodo(
                  Todo(
                    id: const Uuid().v4(),
                    description: textCtrl.text,
                    completed: false,
                  ),
                );
          },
        ),
      ),
      loading: () => Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Center(
        child: Text(err.toString()),
      ),
    );
  }
}
