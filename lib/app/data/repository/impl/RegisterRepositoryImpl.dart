import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_app/app/data/repository/RegisterRepository.dart';

import '../../../presentation/common/firebase_service.dart';
import '../LoginRepository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final String? token = FirebaseService.token;

  @override
  Future<void> registerUser(
      {required String username,
      required String email,
      required String password,
      required String birth,
      required String age,
      required String createdAt,
      required File? image,
      required Function() onSuccess,
      required Function(String error) onError}) async {
    try {
      if (await userExists(username)) {
        onError('El usuario ya existe');
        return;
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String userId = userCredential.user!.uid;
      // TODO: image != null ? await uploadImage('users/$username/$userId.jpg', image) : '';
      String imageUrl = '';

      final userInfo = {
        'id': userId,
        'username': username,
        'password': password,
        'email': email,
        'birth': birth,
        'age': age,
        'token': token,
        'image': imageUrl,
        'createdAt': createdAt,
      };

      await _firestore.collection('user').doc(userId).set(userInfo);
      sendEmailVerification();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('La contraseña es muy débil');
      } else if (e.code == 'email-already-in-use') {
        onError('El email ya está en uso');
      } else {
        onError(e.toString());
      }
    } catch (e) {
      onError('Error al registrar el usuario');
    }
  }

  @override
  Future<bool> userExists(String username) async {
    final QuerySnapshot result = await _firestore
        .collection('user')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  @override
  Future<bool> emailExists(String email) async {
    final QuerySnapshot result = await _firestore
        .collection('user')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  @override
  Future<String> uploadImage(String ref, File file) async {
    final UploadTask uploadTask = _storage.ref().child(ref).putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }
}
