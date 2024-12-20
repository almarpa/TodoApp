import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

ThemeData getAppThemeData(BuildContext context) {
  return ThemeData(
    colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: white,
        secondary: secondary,
        onSecondary: white,
        tertiary: tertiary,
        onTertiary: white,
        error: errorColor,
        outline: outlineColor),

    // TEXT
    textTheme: Theme.of(context).textTheme.apply(
        fontFamily: 'Poppins', bodyColor: textColor, displayColor: textColor),

    // SCAFFOLD
    scaffoldBackgroundColor: white,

    // BOTTOM SHEET
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),

    // TEXT BUTTON
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(greenOscure),
      ),
    ),
  );
}
