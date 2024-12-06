import 'package:todo_app/app/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/app/presentation/screens/home/welcome_screen.dart';
import 'package:todo_app/app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/app/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:todo_app/app/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'app/data/repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  // OLD
  // @override
  // Widget build(BuildContext context) {
  //   return MultiProvider(providers: [
  //     ChangeNotifierProvider(lazy: false, create: (_) => FormProvider()),
  //     ChangeNotifierProvider(lazy: false, create: (_) => LoginProvider()),
  //   ], child: const MyAppView());
  // }
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
        title: 'TodoApp',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const HomeScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        }),
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                background: Colors.white,
                onBackground: Colors.black,
                primary: Color.fromRGBO(206, 147, 216, 1),
                onPrimary: Colors.black,
                secondary: Color.fromRGBO(244, 143, 177, 1),
                onSecondary: Colors.white,
                tertiary: Color.fromRGBO(255, 204, 128, 1),
                error: Colors.red,
                outline: Color(0xFF424242)),

            // SCAFFOLD
            scaffoldBackgroundColor: colorWhite,

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
