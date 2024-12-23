import 'package:equatable/equatable.dart';
import 'package:todo_app/app/domain/model/user_model.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String username;

  const UserEntity(
      {required this.userId, required this.email, required this.username});

  static UserEntity fromJson(Map<String, dynamic> json) => UserEntity(
      userId: json['id'], email: json['email'], username: json['username']);

  Map<String, Object?> toJson() => {
        'id': userId,
        'email': email,
        'username': username,
      };

  UserModel toModel() =>
      UserModel(id: userId, email: email, username: username);

  @override
  List<Object?> get props => [userId, email, username];
}
