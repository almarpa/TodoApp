import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/app/domain/model/models.dart';

@immutable
sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class Loading extends TaskState {}

class TaskAdded extends TaskState {}

class TasksLoaded extends TaskState {
  final List<TaskModel> tasks;

  const TasksLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class Error extends TaskState {
  final String message;

  const Error(this.message);
}
