import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../entities/task_entity.dart';
import '../task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  @override
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    jsonTasks.add(jsonEncode(task.toJson()));
    return prefs.setStringList('tasks', jsonTasks);
  }

  @override
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    return jsonTasks
        .map((jsonTask) => Task.fromJson(jsonDecode(jsonTask)))
        .toList();
  }

  @override
  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList('tasks', jsonTasks);
  }
}
