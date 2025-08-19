import 'dart:convert';
import 'package:pocket_tasks/modals/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskStorage {
  static const _storageKey = "pocket_tasks_v1";

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final tasksJson = jsonEncode(tasks.map((task) => task.toMap()).toList());

    await prefs.setString(_storageKey, tasksJson);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final tasksJson = prefs.getString(_storageKey);
    if (tasksJson == null) return [];

    final List decoded = jsonDecode(tasksJson);
    return decoded.map((map) => Task.fromMap(map)).toList();
  }
}
