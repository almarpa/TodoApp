import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/presentation/login/form_provider.dart';
import 'package:todo_app/app/presentation/login/login_page.dart';
import 'package:todo_app/app/presentation/register/register_provider.dart';

import '../common/image_picker.dart';
import '../common/snackbar.dart';
import '../common/validators.dart';
import '../components/button_decoration_widget.dart';
import '../components/circular_progress_widget.dart';
import '../components/input_decoration_widget.dart';
import '../theme/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? image;

  @override
  void initState() {
    super.initState();
  }

  void submitRegister() async {
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    if (formProvider.formKeys.currentState!.validate()) {
      formProvider.setLoading(true);

      await registerProvider.registerUser(
          username: formProvider.usernameController.text,
          email: formProvider.emailController.text,
          password: formProvider.passwordController.text,
          birth: formProvider.birthController.text,
          age: formProvider.birthController.text,
          image: image,
          onSuccess: () {
            formProvider.setLoading(false);
            showSnackbar(context, "Revise su correo para verificar su cuenta");
            navigateToLoginScreen();
          },
          onError: (error) {
            formProvider.setLoading(false);
            showSnackbar(context, error);
          });
    } else {
      formProvider.setLoading(false);
    }
  }

  void openImagePicker() async {
    image = await uploadImage(context);
    setState(() {});
  }

  void navigateToLoginScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: Form(
        key: formProvider.formKeys,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    openImagePicker();
                  },
                  child: image == null
                      ? const CircleAvatar(
                          radius: 60,
                          backgroundColor: darkBlueColor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: textColor,
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(image!),
                        ),
                ),
                const SizedBox(height: 20),
                InputDecorationWidget(
                  hintText: "Nombre de usuario",
                  labelText: "Ingrese su nombre de usuario",
                  controller: formProvider.usernameController,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.person_outline),
                  validator: Validators.validateUsername,
                ),
                const SizedBox(height: 20),
                InputDecorationWidget(
                  hintText: "user@example.com",
                  labelText: "Ingrese su email",
                  controller: formProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.email_outlined),
                  validator: Validators.emailValidator,
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
                const SizedBox(height: 20),
                getBirth(context, formProvider),
                const SizedBox(height: 30),
                formProvider.isLoading
                    ? const CircularProgressWidget(text: "Registrando...")
                    : ButtomDecorationWidget(
                        text: "Registrarse",
                        onPressed: submitRegister,
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Ya tienes cuenta?"),
                    TextButton(
                      onPressed: () => navigateToLoginScreen(),
                      child: const Text("Inicia Sesión",
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
      ),
    );
  }

  Widget getBirth(BuildContext context, FormProvider formProvider) {
    return InputDecorationWidget(
        hintText: "dd/mm/yyyy",
        labelText: "Ingrese su fecha de nacimiento",
        controller: formProvider.birthController,
        keyboardType: TextInputType.datetime,
        suffixIcon: const Icon(Icons.calendar_today_outlined),
        validator: Validators.birthValidator,
        readOnly: true,
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
                    primary: backgroundColor,
                    onPrimary: Colors.white,
                    surface: textColor,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: backgroundColor,
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(darkBlueColor),
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedData != null) {
            String formatedData = DateFormat('dd/MM/yyyy').format(pickedData);
            setState(() {
              formProvider.birthController.text = formatedData;
            });
          }
        });
  }
}
