import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String title, String description,
        String buttonText, VoidCallback onButtonPressed) =>
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => onButtonPressed(),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
