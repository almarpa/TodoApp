import 'package:equatable/equatable.dart';
import 'package:todo_app/app/data/entities/task_entity.dart';
import 'package:uuid/uuid.dart';

class TaskModel extends Equatable {
  final String id;
  final String description;
  final bool isDone;

  const TaskModel(this.id, this.description, this.isDone);

  TaskEntity toEntity() =>
      TaskEntity(id: id, description: description, isDone: isDone);

  static TaskModel empty(String description) =>
      TaskModel(const Uuid().v4(), description, false);

  @override
  List<Object?> get props => [id, description, isDone];
}
