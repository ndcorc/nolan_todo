import 'package:nolan_todo/models/todo.dart';
import 'package:nolan_todo/providers/sort.dart';
import 'package:nolan_todo/providers/filter.dart';
import 'package:nolan_todo/repositories/todos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos.g.dart';

@riverpod
class Todos extends _$Todos {
  Future<List<Todo>> _fetchTodos() async {
    return await ref.watch(todosRepoProvider).getTodoList();
  }

  @override
  Future<List<Todo>> build() async {
    final todos = await _fetchTodos();
    final filter = ref.watch(filterProvider);
    final sort = ref.watch(sortProvider);

    final filtered = switch (filter) {
      Filter.none => todos,
      Filter.completed => todos.where((todo) => todo.completed).toList(),
      Filter.uncompleted => todos.where((todo) => !todo.completed).toList(),
    };

    return switch (sort) {
      SortOrder.ASC => filtered..sort((a, b) => a.id.compareTo(b.id)),
      SortOrder.DESC => filtered..sort((a, b) => b.id.compareTo(a.id)),
    };
  }

  // Let's allow the UI to add todos.
  Future<void> addTodo(Todo todo) async {
    state = const AsyncValue.loading();
    final newTodos = [...?state.value, todo];
    state = await AsyncValue.guard(() async {
      await ref.watch(todosRepoProvider).saveTodoList(newTodos);
      return _fetchTodos();
    });
  }

  // Let's allow removing todos
  Future<void> removeTodo(String todoId) async {
    state = const AsyncValue.loading();
    final newTodos = [
      for (final todo in state.value!)
        if (todo.id != todoId) todo,
    ];
    state = await AsyncValue.guard(() async {
      await ref.watch(todosRepoProvider).saveTodoList(newTodos);
      return _fetchTodos();
    });
  }

  // Let's mark a todo as completed
  Future<void> toggle(String todoId) async {
    state = const AsyncValue.loading();
    final newTodos = [
      for (final todo in state.value!)
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
    state = await AsyncValue.guard(() async {
      await ref.watch(todosRepoProvider).saveTodoList(newTodos);
      return _fetchTodos();
    });
  }
}
/* 
@riverpod
List<Todo>? filteredTodos(ref) {
  final todos = ref.watch(todosProvider);
  final Filter filter = ref.watch(filterProvider);

  switch (filter) {
    case Filter.none:
      return todos;
    case Filter.completed:
      return todos.where((todo) => todo.completed).toList();
    case Filter.uncompleted:
      return todos.where((todo) => !todo.completed).toList();
  }
}

@riverpod
List<Todo>? sortedTodos(ref) {
  final List<Todo> filteredTodos = ref.watch(filteredTodosProvider);
  final SortOrder sort = ref.watch(sortProvider);

  switch (sort) {
    case SortOrder.ASC:
      return filteredTodos
        ..sort((a, b) => a.description.compareTo(b.description));
    case SortOrder.DESC:
      return filteredTodos
        ..sort((a, b) => b.description.compareTo(a.description));
  }
}
 */
// This will generates a Notifier and NotifierProvider.
// The Notifier class that will be passed to our NotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
// Finally, we are using todosProvider(NotifierProvider) to allow the UI to
// interact with our Todos class.