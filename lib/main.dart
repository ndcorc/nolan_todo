import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/view/simple_todo.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: SimpleTodo(),
      ),
    ),
  );
}
