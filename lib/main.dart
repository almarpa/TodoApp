import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/data/repository/impl/user_repository_impl.dart';
import 'package:todo_app/todo_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  Intl.defaultLocale = 'es_ES';
  await initializeDateFormatting();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();

  runApp(TodoApp(UserRepositoryImpl()));
}
