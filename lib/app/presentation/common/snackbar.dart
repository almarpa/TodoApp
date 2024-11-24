import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: darkBlueColor,
      content: Text(
        content,
        style: const TextStyle(
          color: textColor,
          fontFamily: "MonB",
        ),
      ),
    ),
  );
}
