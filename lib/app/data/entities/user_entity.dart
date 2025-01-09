import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/app/domain/model/user_model.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String username;

  const UserEntity(
      {required this.id, required this.email, required this.username});

  static UserEntity fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  UserModel toModel() => UserModel(id: id, email: email, username: username);

  @override
  List<Object?> get props => [id, email, username];
}
