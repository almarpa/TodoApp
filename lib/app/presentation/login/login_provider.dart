import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../data/repository/LoginRepository.dart';
import '../../data/repository/impl/LoginRepositoryImpl.dart';

enum AuthStatus { notAuthentication, checking, authenticated }

class LoginProvider extends ChangeNotifier {
  final LoginRepository loginRepository = LoginRepositoryImpl();

  AuthStatus authStatus = AuthStatus.notAuthentication;

  Future<dynamic> loginUser({
    required String usernameOrEmail,
    required String password,
    required Function(dynamic) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      authStatus = AuthStatus.checking;
      notifyListeners();

      await loginRepository.loginUser(
          usernameOrEmail, password, onSuccess, onError);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        onError('Usuario o contraseña incorrecta.');
      } else {
        onError(e.toString());
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<dynamic> getUserData(String email) async {
    await loginRepository.getUserData(email);
  }

  // void checkAuthState() {}
}
