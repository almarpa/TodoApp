import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/login_old/login_page.dart';
import 'package:todo_app/app/presentation/routes/routes.dart';
import 'package:todo_app/app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/app/presentation/screens/splash/splash_screen.dart';
import 'package:todo_app/app/presentation/screens/welcome/welcome_screen.dart';

import '../register_old/register_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.welcome: (_) => const WelcomeScreen(),
  Routes.login: (_) => const LoginScreen(),
  Routes.register: (_) => const RegisterScreen(),
  Routes.home: (_) => const HomeScreen(),
  //Routes.profile: (_) => const ProfilePage(),
  //Routes.settings: (_) => const SettingsPage(),
};
