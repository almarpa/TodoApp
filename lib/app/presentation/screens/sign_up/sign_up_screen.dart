import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/domain/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/common/dialogs.dart';
import 'package:todo_app/app/presentation/common/validators.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

import 'bloc/sign_up_bloc.dart';
import '../../widgets/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final birthController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpProcessing = false;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool upToEightCharacters = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        setState(() {
          if (state is SignUpSuccess) {
            signUpProcessing = false;
            showAlertDialog(
                context,
                "Verifica tu correo",
                "Por favor verifica tu correo electrónico para continuar",
                "Aceptar",
                () => Navigator.pop(context));
          } else if (state is SignUpProcess) {
            signUpProcessing = true;
          } else if (state is SignUpFailure) {
            signUpProcessing = false;
            showErrorDialog(context, state.message, "Aceptar",
                () => Navigator.pop(context));
          }
        });
      },
      child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //     width: MediaQuery.of(context).size.width * 0.2,
                //     child: InkWell(
                //       onTap: () {
                //         openImagePicker();
                //       },
                //       child: image == null
                //           ? const CircleAvatar(
                //               radius: 30,
                //               child: Icon(
                //                 Icons.camera_alt_outlined,
                //                 size: 30,
                //                 color: textColor,
                //               ),
                //             )
                //           : CircleAvatar(
                //               radius: 60,
                //               backgroundImage: FileImage(image!),
                //             ),
                //     )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(CupertinoIcons.mail_solid),
                      validator: (val) => Validators.emailValidator(val)),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      onChanged: (val) {
                        if (val != null) validateForm(val);
                      },
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
                      validator: (val) => Validators.passwordValidator(val)),
                ),
                const SizedBox(height: 4),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Visibility(
                            visible: containsUpperCase,
                            child: const Text("⚈  1 mayúscula requerida",
                                style: TextStyle(color: errorColor))),
                        Visibility(
                            visible: containsLowerCase,
                            child: const Text("⚈  1 minúscula requerida",
                                style: TextStyle(color: errorColor))),
                        Visibility(
                            visible: containsNumber,
                            child: const Text(
                                "⚈  1 caracter numérico requerido",
                                style: TextStyle(color: errorColor))),
                        Visibility(
                            visible: containsSpecialChar,
                            child: const Text(
                                "⚈  1 caracter especial requerido",
                                style: TextStyle(color: errorColor))),
                        Visibility(
                            visible: upToEightCharacters,
                            child: const Text("⚈  > 8 caracteres requeridos",
                                style: TextStyle(color: errorColor))),
                      ],
                    )),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                      controller: nameController,
                      hintText: 'Name',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(CupertinoIcons.person_fill),
                      validator: (val) => Validators.userNameValidator(val)),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                      hintText: 'dd/mm/yyyy',
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      validator: Validators.birthValidator,
                      controller: birthController,
                      obscureText: false,
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        DateTime? pickedData = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: primary,
                                ),
                                dialogBackgroundColor: primary,
                                textButtonTheme: TextButtonThemeData(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        WidgetStateProperty.all(greenOscure),
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedData != null) {
                          final DateFormat formatter = DateFormat('dd/MM/yyyy');
                          String formatedData = formatter.format(pickedData);
                          setState(() {
                            birthController.text = formatedData;
                          });
                        }
                      },
                    )),
                const SizedBox(height: 10),
                !signUpProcessing
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  context.read<SignUpBloc>().add(SignUpRequired(
                                      UserModel.empty.copyWith(
                                        email: emailController.text,
                                        username: nameController.text,
                                      ),
                                      passwordController.text));
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                      )
                    : const CircularProgressIndicator(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateForm(String val) {
    setState(() {
      if (!Validators.containsUppercase(val)) {
        containsUpperCase = true;
        containsLowerCase = false;
        containsNumber = false;
        containsSpecialChar = false;
        upToEightCharacters = false;
      } else if (!Validators.containsLowercase(val)) {
        containsLowerCase = true;
        containsUpperCase = false;
        containsNumber = false;
        containsSpecialChar = false;
        upToEightCharacters = false;
      } else if (!Validators.containsDigits(val)) {
        containsNumber = true;
        containsUpperCase = false;
        containsLowerCase = false;
        containsSpecialChar = false;
        upToEightCharacters = false;
      } else if (!Validators.containsSpecialCharacter(val)) {
        containsSpecialChar = true;
        containsUpperCase = false;
        containsLowerCase = false;
        containsNumber = false;
        upToEightCharacters = false;
      } else if (val.length < 8) {
        upToEightCharacters = true;
        containsUpperCase = false;
        containsLowerCase = false;
        containsNumber = false;
        containsSpecialChar = false;
      } else if (areAllValids(val)) {
        containsUpperCase = false;
        containsLowerCase = false;
        containsNumber = false;
        containsSpecialChar = false;
        upToEightCharacters = false;
      } else {
        containsUpperCase = true;
        containsLowerCase = true;
        containsNumber = true;
        containsSpecialChar = true;
        upToEightCharacters = true;
      }
    });
  }

  bool areAllValids(String val) {
    return Validators.containsUppercase(val) &&
        Validators.containsLowercase(val) &&
        Validators.containsDigits(val) &&
        Validators.containsSpecialCharacter(val) &&
        val.length >= 8;
  }
}
