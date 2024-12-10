import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String? errorDescription,
        String? buttonText, VoidCallback onButtonPressed) =>
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorDescription ??
              "Ha ocurrido un error inesperado. Intentalo de nuevo más tarde."),
          actions: [
            TextButton(
              onPressed: () => onButtonPressed(),
              child: Text(buttonText ?? "Aceptar"),
            ),
          ],
        );
      },
    );

void showAlertDialog(BuildContext context, String title, String description,
        String? buttonText, VoidCallback onButtonPressed) =>
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => onButtonPressed(),
              child: Text(buttonText ?? "Aceptar"),
            ),
          ],
        );
      },
    );
