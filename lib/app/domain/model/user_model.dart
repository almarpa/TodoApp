import 'package:equatable/equatable.dart';
import 'package:todo_app/app/data/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String username;

  const UserModel(
      {required this.id, required this.email, required this.username});

  static const empty = UserModel(id: '', email: '', username: '');

  UserModel copyWith({String? id, String? email, String? username}) {
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username);
  }

  UserEntity toEntity() {
    return UserEntity(userId: id, email: email, username: username);
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
        id: entity.userId, email: entity.email, username: entity.username);
  }

  @override
  List<Object?> get props => [id, email, username];
}
