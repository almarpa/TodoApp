import 'package:equatable/equatable.dart';
import 'package:todo_app/app/domain/model/task_model.dart';

class TaskEntity extends Equatable {
  final String uuid;
  final String description;
  final bool isDone;

  const TaskEntity(
      {required this.uuid, required this.description, required this.isDone});

  static TaskEntity fromJson(Map<String, dynamic> json) => TaskEntity(
      uuid: json['id'],
      description: json['description'],
      isDone: json['isDone']);

  Map<String, dynamic> toJson() => {
        'id': uuid,
        'description': description,
        'isDone': isDone,
      };

  TaskModel toModel() => TaskModel(uuid, description, isDone);

  @override
  List<Object?> get props => [uuid, description, isDone];
}
