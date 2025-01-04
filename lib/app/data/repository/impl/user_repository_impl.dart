import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/domain/model/user_model.dart';

import '../user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Stream<User?> get user =>
      _firebaseAuth.authStateChanges().map((firebaseUser) {
        return firebaseUser;
      });

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> isUserEmailVerified() async {
    return _firebaseAuth.currentUser!.emailVerified;
  }

  @override
  Future<UserModel> signUp(UserModel myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      await logOut();
      return myUser.setId(user.user!.uid);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(UserModel myUser) async {
    try {
      await _firestore
          .collection('user')
          .doc(myUser.id)
          .set(myUser.toEntity().toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
