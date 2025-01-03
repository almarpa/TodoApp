import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/di/injector.dart';
import 'package:todo_app/todo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the date formatting
  Intl.defaultLocale = 'es_ES';
  await initializeDateFormatting();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize the dependency injection
  configureDependencies();

  runApp(const TodoApp());
}
