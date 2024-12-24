import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/data/entities/task_entity.dart';
import 'package:todo_app/app/domain/model/task_model.dart';
import 'package:todo_app/app/domain/model/user_model.dart';

import '../user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');

  UserRepositoryImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

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
      await usersCollection.doc(myUser.id).set(myUser.toEntity().toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<List<TaskModel>> get tasks async* {
    yield* usersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks')
        .snapshots()
        .map(
          (snapshot) => List<TaskModel>.from(
            snapshot.docs
                .map((doc) => TaskEntity.fromJson(doc.data()).toModel()),
          ),
        );
  }

  @override
  Future<void> checkTask(TaskModel taskModel) async {
    try {
      QuerySnapshot<Map<String, dynamic>> taskQuery = await usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .where('id', isEqualTo: taskModel.uuid)
          .get();

      if (taskQuery.docs.isEmpty) return;

      await taskQuery.docs.first.reference
          .update({'isDone': !taskModel.isDone});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .add({
        'id': task.uuid,
        'description': task.description,
        'isDone': task.isDone,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> taskQuery = await usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .where('id', isEqualTo: taskId)
          .get();

      if (taskQuery.docs.isEmpty) return;

      await taskQuery.docs.first.reference.delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
