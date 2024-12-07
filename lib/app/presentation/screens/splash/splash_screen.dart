import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/presentation/login_old/login_page.dart';
import 'package:todo_app/app/presentation/screens/home/home_screen.dart';

import '../../widgets/circular_progress_widget.dart';
import '../../login_old/login_provider.dart';
import '../../register_old/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late bool isFirstTime;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _checkUserFirstTime();
  }

  Future<void> _initPrefs() async {
    isFirstTime = true; // TODO: retrieve from shared preferences
  }

  void _checkUserFirstTime() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstTime) {
      // TODO: save in shared preferences
      navigateToLoginScreen();
    } else {
      await _checkAuthStatus();
    }
  }

  Future<void> _checkAuthStatus() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final user = _auth.currentUser;
    if (user != null && user.email != null && user.emailVerified) {
      dynamic userData = await loginProvider.getUserData(user.email!);
      // TODO: check before if user is logged in shared preferences
      navigateToHomeScreen(context, userData);
    } else {
      navigateToLoginScreen();
    }
  }

  void navigateToRegisterScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  void navigateToLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void navigateToHomeScreen(context, userData) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(
                // TODO: userData: userData
                )));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressWidget(text: "Cargando..."),
      ),
    );
  }
}
