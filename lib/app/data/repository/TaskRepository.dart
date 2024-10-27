import 'package:todo_app/app/domain/model/Task.dart';

abstract class TaskRepository {
  Future<bool> addTask(Task task);
  Future<List<Task>> getTasks();
  Future<bool> saveTasks(List<Task> tasks);
}
