import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nolan_todo/models/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos.g.dart';

/* final todosRepo =
    Provider.autoDispose<TodosRepository>((ref) => TodosRepository());
 */
@riverpod
TodosRepository todosRepo(ref) => TodosRepository();

final _todoListKey = 'todoListKey';

class TodosRepository {
  TodosRepository();

  Future<List<Todo>> getTodoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final List<Map<String, dynamic>> todosJsonList =
          List<Map<String, dynamic>>.from(
              jsonDecode(prefs.getString(_todoListKey) ?? '[]'));
      return todosJsonList.map((json) => Todo.fromJson(json)).toList();
    } catch (err) {
      prefs.clear();
      return [];
    }
  }

  Future<void> saveTodoList(List<Todo> todoList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_todoListKey,
        jsonEncode(todoList.map((todo) => todo.toJson()).toList()));
  }
}

/* 
abstract class TodosRepository {
  Future<List<Todo>> getTodoList();
  Future<void> saveTodoList(List<Todo> todoList);
}

class TodosRepositoryImpl implements TodosRepository {
  final Reader _read;
  TodosRepositoryImpl(this._read);

  Future<List<Todo>> getTodoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> todoListJsonList =
        List<Map<String, dynamic>>.from(
            jsonDecode(prefs.getString(_todoListKey) ?? '[]'));
    return todoListJsonList.map((json) => Todo.fromJson(json)).toList();
  }

  Future<void> saveTodoList(List<Todo> todoList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_todoListKey,
        jsonEncode(todoList.map((todo) => todo.toMap()).toList()));
  }
}
 */