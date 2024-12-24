import 'package:equatable/equatable.dart';
import 'package:todo_app/app/data/entities/task_entity.dart';
import 'package:uuid/uuid.dart';

class TaskModel extends Equatable {
  final String uuid;
  final String description;
  final bool isDone;

  const TaskModel(this.uuid, this.description, this.isDone);

  static TaskModel empty(String description) =>
      TaskModel(const Uuid().v4(), description, false);

  TaskModel copyWith({required String description, required bool isDone}) =>
      TaskModel(uuid, this.description, this.isDone);

  TaskEntity toEntity() =>
      TaskEntity(uuid: uuid, description: description, isDone: isDone);

  @override
  List<Object?> get props => [uuid, description, isDone];
}
