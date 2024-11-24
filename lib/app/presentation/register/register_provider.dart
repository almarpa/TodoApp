import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/data/repository/RegisterRepository.dart';
import 'package:todo_app/app/data/repository/impl/RegisterRepositoryImpl.dart';

enum UserRole { admin, user, superAdmin }

class RegisterProvider extends ChangeNotifier {
  final RegisterRepository registerRepository = RegisterRepositoryImpl();

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required String birth,
    required String age,
    required File? image,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    final bool userNameExists = await registerRepository.userExists(username);
    if (userNameExists) {
      onError("El nombre de usuario ya existe");
      return;
    }

    final bool existEmail = await registerRepository.emailExists(email);
    if (existEmail) {
      onError("El email ya existe");
      return;
    }

    if (image == null) {
      onError("Ingrese una imagen de perfil");
      return;
    }

    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    final DateTime dateBirth = DateFormat('dd/MM/yyyy').parse(birth);
    int age = now.year - dateBirth.year;
    if (now.month < dateBirth.month ||
        (now.month == dateBirth.month && now.day < dateBirth.day)) {
      age--;
    }

    await registerRepository.registerUser(
        username: username,
        email: email,
        password: password,
        birth: birth,
        age: age.toString(),
        createdAt: formattedDate,
        image: image,
        onSuccess: onSuccess,
        onError: onError);
  }
}
