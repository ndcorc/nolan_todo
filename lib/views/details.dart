import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nolan_todo/providers/sort.dart';

/// The details screen for either the A, B or C screen.
class Details extends HookConsumerWidget {
  /// Constructs a [Details].
  const Details({
    required this.label,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myController = useTextEditingController();
    final sortCtrl = ref.read(sortProvider.notifier);

    final handleChangeSort = () => {
          sortCtrl.state =
              sortCtrl.state == SortOrder.ASC ? SortOrder.DESC : SortOrder.ASC,
        };

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'Details (Page Two)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Alert Text"),
                contentTextStyle: TextStyle(
                  color: Colors.black,
                ),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
