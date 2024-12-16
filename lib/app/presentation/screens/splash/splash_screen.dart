import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/widgets/custom_circular_progress.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomCircularProgress(text: "Cargando..."),
    );
  }
}
