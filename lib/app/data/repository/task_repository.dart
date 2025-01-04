import 'package:todo_app/app/domain/model/task_model.dart';

abstract class TaskRepository {
  Stream<List<TaskModel>> get tasks;

  Future<void> checkTask(TaskModel task);
  Future<void> addTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}
