import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/presentation/common/dialogs.dart';
import 'package:todo_app/app/presentation/common/validators.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_event.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_state.dart';
import 'package:todo_app/app/presentation/widgets/custom_text_button.dart';

import '../../widgets/custom_text_field.dart';
import 'bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool signInProcessing = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? error;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        setState(() {
          state.when(
            initial: () {
              signInProcessing = false;
            },
            success: () {
              signInProcessing = false;
            },
            failure: (message) {
              signInProcessing = false;
              error = 'Usuario o contraseña incorrecto';
            },
            process: () {
              signInProcessing = true;
            },
            emailNotVerified: () {
              signInProcessing = false;
              showAlertDialog(
                context,
                "Verifica tu correo",
                "Por favor verifica tu correo electrónico para continuar",
                "Aceptar",
                () => Navigator.pop(context),
              );
            },
          );
        });
      },
      child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(CupertinoIcons.mail_solid),
                      errorMsg: error,
                      validator: (val) => Validators.emailValidator(val))),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  errorMsg: error,
                  validator: (val) => Validators.passwordValidator(val),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        if (obscurePassword) {
                          iconPassword = CupertinoIcons.eye_fill;
                        } else {
                          iconPassword = CupertinoIcons.eye_slash_fill;
                        }
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              !signInProcessing
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: CustomTextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(SignInRequired(
                                emailController.text, passwordController.text));
                          }
                        },
                        text: 'Sign In',
                      ),
                    )
                  : const CircularProgressIndicator(),
            ],
          )),
    );
  }
}
