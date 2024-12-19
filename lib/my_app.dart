import 'package:todo_app/app/presentation/screens/splash/splash_screen.dart';
import 'package:todo_app/app/presentation/theme/app_theme.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/app/presentation/screens/auth/auth_screen.dart';
import 'package:todo_app/app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:todo_app/app/presentation/screens/auth/bloc/auth_bloc.dart';
import 'app/data/repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthBloc>(
      create: (context) => AuthBloc(userRepository: userRepository),
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
        home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state.status == AuthStatus.unknown) {
            return const SplashScreen();
          } else if (state.status == AuthStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                  userRepository: context.read<AuthBloc>().userRepository),
              child: const HomeScreen(),
            );
          } else {
            return const AuthScreen();
          }
        }),
        theme: appThemeData);
  }
}
