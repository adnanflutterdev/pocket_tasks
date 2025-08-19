import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/modals/task.dart';
import 'package:pocket_tasks/modals/task_storage.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await TaskStorage.loadTasks();
    state = tasks;
  }

  Future<void> addTask(Task task) async {
    state = [...state, task];
    await TaskStorage.saveTasks(state);
  }

  Future<void> toggleTask(int id) async {
    state = state
        .map(
          (task) => task.id == id
              ? Task(
                  id: task.id,
                  title: task.title,
                  isDone: !task.isDone,
                  createdAt: task.createdAt,
                )
              : task,
        )
        .toList();
    await TaskStorage.saveTasks(state);
  }

  Future<void> removeTask(int id) async {
    state = state.where((task) => task.id != id).toList();
    await TaskStorage.saveTasks(state);
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier,List<Task>>((ref) => TaskNotifier());



