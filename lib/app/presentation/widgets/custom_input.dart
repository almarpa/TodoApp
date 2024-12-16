import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomInput extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines;
  final bool readOnly;
  final String hintText;
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Color color;

  const CustomInput({
    super.key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines,
    this.readOnly = false,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.controller,
    this.color = darkBlueColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      onTap: onTap,
      style: TextStyle(
        color: color,
        fontFamily: "MonM",
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontFamily: "MonM",
        ),
        hintStyle: TextStyle(
          color: darkBlueColor.withOpacity(0.5),
          fontFamily: "MonM",
        ),
        labelStyle: TextStyle(
          color: color,
          fontFamily: "MonM",
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }
}
