import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nolan_todo/models/todo.dart';
import 'package:nolan_todo/providers/sort.dart';
import 'package:nolan_todo/providers/todos.dart';
import 'package:nolan_todo/repositories/todos.dart';
import 'package:uuid/uuid.dart';

class _TodoRepositoryImplDummy implements TodosRepository {
  List<Todo> inMemoryTodoList = [];

  Future<List<Todo>> getTodoList() async {
    return inMemoryTodoList;
  }

  Future<void> saveTodoList(List<Todo> todoList) async {
    inMemoryTodoList = todoList;
  }
}

void main() {
  group('test ViewController behaviors:', () {
    final container = ProviderContainer(
      overrides: [
        /* todosRepo.overrideWith(
          Provider.autoDispose<TodosRepository>((ref) => TodosRepository()),
        ) */
      ],
    );
    test('initial value of todo list is null', () async {
      expect(container.read(todosProvider), []);
    });

    test('initial load is empty array', () async {
      await container.read(todosProvider.notifier).build();
      expect(container.read(todosProvider), []);
    });

    /* test('add first todo', () async {
      await container.read(todosProvider.notifier)
        ..addTodo(Todo(
          id: const Uuid().v4(),
          description: TextEditingController(text: 'first').text,
          completed: false,
        ));
      expect(container.read(todosProvider)![0].description, 'first');
    }); */

    /* test('add second todo', () async {
      await container.read(todosProvider.notifier)
        ..addTodo(Todo(
          id: const Uuid().v4(),
          description: TextEditingController(text: 'second').text,
          completed: false,
        ));
      expect(container.read(sortedTodosProvider)![1].description, 'second');
    }); */

    /* test('toggle status', () async {
      final Todo firstTodo = container.read(sortedTodosProvider)![0];
      await container.read(todosProvider.notifier)
        ..toggle(firstTodo.id);
      expect(container.read(sortedTodosProvider)![0].completed, true);
    }); */

    /* test('change sort order', () async {
      container.read(sortProvider.notifier).state = SortOrder.ASC;
      expect(container.read(sortedTodosProvider)![0].description, 'second');
    });

    test('dispose', () async {
      container.read(todosProvider.notifier).build();
      expect(container.read(sortedTodosProvider), []);
    }); */
  });
}
