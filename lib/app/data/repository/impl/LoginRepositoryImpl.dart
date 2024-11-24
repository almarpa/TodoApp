import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../presentation/common/firebase_service.dart';
import '../LoginRepository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final User? user = FirebaseAuth.instance.currentUser;
  final String? token = FirebaseService.token;

  @override
  Future<dynamic> loginUser(String usernameOrEmail, String password,
      Function(dynamic) onSuccess, Function(String p1) onError) async {
    final String usernameOrEmailLowerCase = usernameOrEmail.toLowerCase();
    final QuerySnapshot userResult = await _firestore
        .collection('user')
        .where('username', isEqualTo: usernameOrEmailLowerCase)
        .limit(1)
        .get();

    if (userResult.docs.isNotEmpty) {
      final String email = userResult.docs.first.get('email');
      return await verifyUser(email, password, onSuccess, onError);
    }

    final QuerySnapshot emailResult = await _firestore
        .collection('user')
        .where('email', isEqualTo: usernameOrEmailLowerCase)
        .limit(1)
        .get();

    if (emailResult.docs.isNotEmpty) {
      final String email = emailResult.docs.first.get('email');
      return await verifyUser(email, password, onSuccess, onError);
    }

    onError('No se encontró el usuario o email ingresado.');
  }

  Future<void> verifyUser(String email, String password, Function onSuccess,
      Function(String error) onError) async {
    final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Verificar si el usuario ha verificado su correo electronico
    if (user != null && user!.emailVerified) {
      dynamic userData = await getUserData(user!.email!);

      // actualizar el token en la colección user
      await updateToken(token!, user!.email!);

      //cambiar estado de autenticacion
      //loginProvider.checkAuthState();
      onSuccess(userData);
      return;
    } else {
      onError("EMAIL_NOT_VERIFIED");
      return;
    }
  }

  @override
  Future<dynamic> getUserData(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection('user')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      return result.docs[0].data();
    }
    return null;
  }

  Future<void> updateToken(String token, String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection('user')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      final String userId = result.docs[0].get('id');
      await _firestore.collection('user').doc(userId).update({'token': token});
    }
  }

  /*@override
  Future<StreamSubscription<AuthStatus>> checkAuthState() async {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        AuthStatus.notAuthentication;
      } else {
        AuthStatus.authenticated;
      }
    });
  }*/
}
