import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/routes/routes.dart';
import 'package:todo_app/app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/app/presentation/screens/auth/auth_screen.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.auth: (_) => const AuthScreen(),
  Routes.home: (_) => const HomeScreen(),
  //Routes.profile: (_) => const ProfilePage(),
  //Routes.settings: (_) => const SettingsPage(),
};
