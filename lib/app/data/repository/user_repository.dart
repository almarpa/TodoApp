import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/domain/model/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<UserModel> signUp(UserModel myUser, String password);

  Future<void> setUserData(UserModel user);

  Future<void> signIn(String email, String password);

  Future<bool> isUserEmailVerified();

  Future<void> logOut();
}
