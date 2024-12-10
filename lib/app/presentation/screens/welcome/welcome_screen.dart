import 'dart:ui';

import 'package:todo_app/app/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:todo_app/app/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              positionedCircles(context),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Text(
                    'I \n Have  \n   A \n     Plan',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: white,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5),
                          labelColor: Theme.of(context).colorScheme.onSurface,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          BlocProvider<SignInBloc>(
                            create: (context) => SignInBloc(
                                userRepository: context
                                    .read<AuthenticationBloc>()
                                    .userRepository),
                            child: const SignInScreen(),
                          ),
                          BlocProvider<SignUpBloc>(
                            create: (context) => SignUpBloc(
                                userRepository: context
                                    .read<AuthenticationBloc>()
                                    .userRepository),
                            child: const SignUpScreen(),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget positionedCircles(BuildContext context) {
  return Stack(
    children: [
      Align(
        alignment: const AlignmentDirectional(20, -1.2),
        child: CircleContainer(
          diameter: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(-2.7, -1.2),
        child: CircleContainer(
          diameter: MediaQuery.of(context).size.width / 1.3,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(2.7, -1.2),
        child: CircleContainer(
          diameter: MediaQuery.of(context).size.width / 1.3,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    ],
  );
}

class CircleContainer extends StatelessWidget {
  final double diameter;
  final Color color;

  const CircleContainer(
      {super.key, required this.diameter, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
