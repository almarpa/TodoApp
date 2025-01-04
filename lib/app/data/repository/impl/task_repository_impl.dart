import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/data/entities/task_entity.dart';
import 'package:todo_app/app/data/repository/task_repository.dart';
import 'package:todo_app/app/domain/model/task_model.dart';

@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final FirebaseFirestore _firestore;
  TaskRepositoryImpl(this._firestore);

  @override
  Stream<List<TaskModel>> get tasks async* {
    yield* _firestore
        .collection('user')
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
      QuerySnapshot<Map<String, dynamic>> taskQuery = await _firestore
          .collection('user')
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
      await _firestore
          .collection('user')
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
      QuerySnapshot<Map<String, dynamic>> taskQuery = await _firestore
          .collection('user')
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
