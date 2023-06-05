import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum SortOrder {
  ASC,
  DESC,
}

final sortProvider = StateProvider<SortOrder>((ref) => SortOrder.ASC);
