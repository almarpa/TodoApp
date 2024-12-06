import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/data/repository/impl/user_repository_impl.dart';
import 'package:todo_app/my_app.dart';
import 'app/presentation/common/firebase_service.dart';

void main() async {
  Intl.defaultLocale = 'es_ES';
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeApp();

  runApp(MyApp(UserRepositoryImpl()));
}
