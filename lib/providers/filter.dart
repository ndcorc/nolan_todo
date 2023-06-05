import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum Filter {
  none,
  completed,
  uncompleted,
}

final filterProvider = StateProvider<Filter>((ref) => Filter.none);
