import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String username;

  const UserEntity(
      {required this.userId, required this.email, required this.username});

  Map<String, Object?> toDocument() {
    return {
      'id': userId,
      'email': email,
      'username': username,
    };
  }

  static UserEntity fromDocument(Map<String, dynamic> doc) {
    return UserEntity(
        userId: doc['id'], email: doc['email'], username: doc['username']);
  }

  @override
  List<Object?> get props => [userId, email, username];
}
