import 'package:equatable/equatable.dart';
import 'package:todo_app/app/data/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String username;

  const UserModel(
      {required this.id, required this.email, required this.username});

  static empty(String email, String username) =>
      UserModel(id: '', email: email, username: username);

  UserModel setId(String id) =>
      UserModel(id: id, email: email, username: username);

  UserEntity toEntity() =>
      UserEntity(userId: id, email: email, username: username);

  @override
  List<Object?> get props => [id, email, username];
}
