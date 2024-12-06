import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ButtomDecorationWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  const ButtomDecorationWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = darkBlueColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(100),
        color: color,
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "MonB",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
