import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

final ThemeData appThemeData = ThemeData(
  colorScheme: const ColorScheme.light(
      primary: primary,
      onPrimary: white,
      secondary: secondary,
      onSecondary: white,
      tertiary: tertiary,
      onTertiary: white,
      error: errorColor,
      outline: outlineColor),

  // SCAFFOLD
  scaffoldBackgroundColor: white,

  // TEXT
  // textTheme: Theme.of(context).textTheme.apply(
  //     fontFamily: 'Poppins', bodyColor: textColor, displayColor: textColor),

  // BOTTOM SHEET
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Colors.transparent),

  // ELEVATED BUTTON
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //         minimumSize: const Size(double.infinity, 50),
  //         foregroundColor: Colors.white,
  //         backgroundColor: primary,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         textStyle: Theme.of(context)
  //             .textTheme
  //             .bodyMedium
  //             ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700)))
);
