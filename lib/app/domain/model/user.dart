import 'package:equatable/equatable.dart';
import 'package:todo_app/app/data/entities/user_entity.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String username;

  const MyUser({required this.id, required this.email, required this.username});

  static const empty = MyUser(id: '', email: '', username: '');

  MyUser copyWith({String? id, String? email, String? username}) {
    return MyUser(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username);
  }

  MyUserEntity toEntity() {
    return MyUserEntity(userId: id, email: email, username: username);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        id: entity.userId, email: entity.email, username: entity.username);
  }

  @override
  List<Object?> get props => [id, email, username];
}
