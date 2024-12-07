import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/presentation/register_old/register_page.dart';

import '../common/snackbar.dart';
import '../theme/colors.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  void onFormLogin(
    String usernameOrEmail,
    String password,
    context,
  ) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    // if (formProvider.formKeys.currentState!.validate()) {
    //   formProvider.setLoading(true);

    //   loginProvider.loginUser(
    //     usernameOrEmail: usernameOrEmail.toLowerCase(),
    //     password: password,
    //     onSuccess: (userData) async {
    //       formProvider.setLoading(false);
    //       navigateToHomeScreen(context, userData);
    //     },
    //     onError: (String error) {
    //       formProvider.setLoading(false);
    //       manageError(error, context);
    //     },
    //   );
    // } else {
    //   formProvider.setLoading(false);
    // }
  }

  void manageError(String error, context) {
    if (error == "EMAIL_NOT_VERIFIED") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Verifica tu correo"),
            content: const Text(
                "Por favor verifica tu correo electrónico para continuar"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        },
      );
    } else {
      showSnackbar(context, error.toString());
    }
  }

  void hidKeyboard(context) {
    FocusScope.of(context).unfocus();
  }

  void navigateToRegisterScreen(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const RegisterScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: greenOscure,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  color: textColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          /*SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formProvider.formKeys,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    InputDecorationWidget(
                      hintText: "user@example.com",
                      labelText: "Ingrese su correo o email",
                      controller: formProvider.userOrEmailController,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: const Icon(Icons.email_outlined),
                      validator: Validators.emailOrUser,
                    ),
                    const SizedBox(height: 20),
                    InputDecorationWidget(
                      hintText: "********",
                      labelText: "Ingrese su contraseña",
                      controller: formProvider.passwordController,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          formProvider.obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          formProvider.setObscureText();
                        },
                      ),
                      obscureText: formProvider.obscureText,
                      validator: Validators.passwordValidator,
                    ),
                    const SizedBox(height: 30),
                    formProvider.isLoading
                        ? const CircularProgressWidget(text: "Validando...")
                        : ButtomDecorationWidget(
                            text: "Inicia Sesión",
                            onPressed: () {
                              hidKeyboard(context);
                              onFormLogin(
                                formProvider.userOrEmailController.text,
                                formProvider.passwordController.text,
                                context,
                              );
                            },
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("¿No tienes cuenta?"),
                        TextButton(
                          onPressed: () => navigateToRegisterScreen(context),
                          child: const Text("Registrate",
                              style: TextStyle(
                                color: darkBlueColor,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),*/
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
