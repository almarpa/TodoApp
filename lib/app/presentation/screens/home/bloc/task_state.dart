import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/app/domain/model/task_model.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  factory TaskState.loading() = Loading;
  factory TaskState.taskAdded() = TaskAdded;
  factory TaskState.tasksLoaded(List<TaskModel> tasks) = TasksLoaded;
  factory TaskState.error(String message) = Error;
}
