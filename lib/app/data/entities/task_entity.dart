import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/app/domain/model/task_model.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity extends Equatable {
  final String id;
  final String description;
  final bool isDone;

  const TaskEntity(
      {required this.id, required this.description, required this.isDone});

  // Deserializes the given [JsonMap] into a [Todo].
  static TaskEntity fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  // Converts this [Todo] into a JSON-serializable [Map].
  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  TaskModel toModel() => TaskModel(id, description, isDone);

  @override
  List<Object?> get props => [id, description, isDone];
}
