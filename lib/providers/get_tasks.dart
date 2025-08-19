import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/modals/task.dart';
import 'package:pocket_tasks/providers/filters.dart';
import 'package:pocket_tasks/providers/search_provider.dart';
import 'package:pocket_tasks/providers/task_provider.dart';

final getTasks = Provider<List<Task>>((ref) {
  List<Task> allTasks = ref.watch(taskProvider);
  int index = ref.watch(filterIndexProvider);
  String searchedText = ref.watch(searchedTextProvider).trim().toLowerCase();
  bool isEmpty = searchedText.isEmpty;
  if (index == 0) {
    if (isEmpty) {
      return allTasks;
    } else {
      return allTasks
          .where((task) => task.title.toLowerCase().contains(searchedText))
          .toList();
    }
  } else {
    List<Task> filteredTasks = allTasks
        .where(
          (task) => index == 1 ? task.isDone == false : task.isDone == true,
        )
        .toList();
    if (isEmpty) {
      return filteredTasks;
    } else {
      return filteredTasks
          .where((task) => task.title.toLowerCase().contains(searchedText))
          .toList();
    }
  }
});
