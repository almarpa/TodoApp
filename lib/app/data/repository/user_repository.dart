import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/domain/model/user_model.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<UserModel> signUp(UserModel myUser, String password);
  Future<void> signIn(String email, String password);
  Future<void> logOut();
  Future<void> setUserData(UserModel user);
  Future<bool> isUserEmailVerified();
}
