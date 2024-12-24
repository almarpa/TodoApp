import 'package:todo_app/app/presentation/screens/auth/bloc/auth_state.dart';
import 'package:todo_app/app/presentation/screens/splash/splash_screen.dart';
import 'package:todo_app/app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/app/presentation/screens/auth/auth_screen.dart';
import 'package:todo_app/app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:todo_app/app/presentation/screens/auth/bloc/auth_bloc.dart';
import 'app/data/repository/user_repository.dart';

class TodoApp extends StatelessWidget {
  final UserRepository userRepository;
  const TodoApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthBloc>(
      create: (context) => AuthBloc(userRepository: userRepository),
      child: MaterialApp(
          title: 'Todo App',
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return state.when(
              unknown: () {
                return const SplashScreen();
              },
              unauthenticated: () {
                return const AuthScreen();
              },
              notVerified: () {
                return const AuthScreen();
              },
              authenticated: (_) {
                return BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository: context.read<AuthBloc>().userRepository),
                  child: HomeScreen(context.read<AuthBloc>().userRepository),
                );
              },
            );
          }),
          theme: getAppThemeData(context)),
    );
  }
}
