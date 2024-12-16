import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleH1 extends StatelessWidget {
  final String title;
  final Color? color;

  const TitleH1({
    super.key,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontFamily: "MonB",
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
