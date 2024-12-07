import 'package:flutter/foundation.dart';
import 'package:todo_app/app/data/repository/task_repository.dart';
import 'package:todo_app/app/data/repository/impl/task_repository_impl.dart';
import 'package:todo_app/app/data/entities/task_entity.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];
  List<Task> get taskList => _taskList;

  final TaskRepository _taskRepository = TaskRepositoryImpl();

  Future<void> fetchTasks() async {
    _taskList = await _taskRepository.getTasks();
    notifyListeners();
  }

  void onTaskDoneChange(Task task) {
    task.done = !task.done;
    _taskRepository.saveTasks(taskList);
    notifyListeners();
  }

  void addNewTask(Task task) {
    _taskRepository.addTask(task);
    fetchTasks();
  }
}
