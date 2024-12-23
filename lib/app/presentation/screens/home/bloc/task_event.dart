import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/app/domain/model/models.dart';

@immutable
sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class CheckTaskEvent extends TaskEvent {
  final TaskModel task;
  const CheckTaskEvent(this.task);
}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;
  const AddTaskEvent(this.task);
}

class TasksUpdatedEvent extends TaskEvent {
  final List<TaskModel> tasks;
  const TasksUpdatedEvent(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;
  const DeleteTaskEvent(this.taskId);
}
