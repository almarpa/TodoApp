import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/app/domain/model/task_model.dart';

part 'task_event.freezed.dart';

@freezed
class TaskEvent with _$TaskEvent {
  factory TaskEvent.checkTask(TaskModel task) = CheckTaskEvent;
  factory TaskEvent.addTask(TaskModel task) = AddTaskEvent;
  factory TaskEvent.tasksLoaded(List<TaskModel> tasks) = TasksLoadedEvent;
  factory TaskEvent.deleteTask(String taskId) = DeleteTaskEvent;
}
