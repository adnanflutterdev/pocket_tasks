import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/providers/task_provider.dart';

final taskCompletionIndicator = Provider<Map<String, dynamic>>((ref) {
  final allTask = ref.watch(taskProvider);
  int taskLength = allTask.length;
  int completedTaskLength = allTask
      .where((task) => task.isDone == true)
      .toList()
      .length;
  return {
    'label': '$completedTaskLength/$taskLength',
    'percentage': completedTaskLength / taskLength,
  };
});
