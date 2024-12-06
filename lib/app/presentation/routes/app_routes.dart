import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/login_old/login_page.dart';
import 'package:todo_app/app/presentation/routes/routes.dart';
import 'package:todo_app/app/presentation/screens/splash/splash_screen.dart';
import 'package:todo_app/app/presentation/screens/task_list/task_list_screen.dart';

import '../register_old/register_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.splash: (_) => const SplashScreen(),
  Routes.login: (_) => const LoginScreen(),
  Routes.register: (_) => const RegisterScreen(),
  Routes.taskList: (_) => const TaskListScreen(),
  //Routes.profile: (_) => const ProfilePage(),
  //Routes.settings: (_) => const SettingsPage(),
};
