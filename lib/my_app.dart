import 'package:todo_app/app/presentation/screens/splash/splash_screen.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/app/presentation/screens/auth/auth_screen.dart';
import 'package:todo_app/app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/app/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:todo_app/app/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'app/data/repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IHaveAPlan',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.unknown) {
            return const SplashScreen();
          } else if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const HomeScreen(),
            );
          } else {
            return const AuthScreen();
          }
        }),
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: primary,
                onPrimary: white,
                secondary: secondary,
                onSecondary: white,
                tertiary: tertiary,
                onTertiary: white,
                error: errorColor,
                outline: outlineColor),

            // SCAFFOLD
            scaffoldBackgroundColor: white,

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
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w700)))));
  }
}
