import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/splash/SplashScreen.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: primary, primary: primary, secondary: primary),

          // SCAFFOLD
          scaffoldBackgroundColor: backgroundColor,

          // TEXT
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
              bodyColor: textColor,
              displayColor: textColor),

          // BOTTOM SHEET
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),

          // ELEVATED BUTTON
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700)))),
      home: const SplashScreen(),
    );
  }
}
