import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/widgets/title_h1.dart';

import '../theme/colors.dart';

class CustomCircularProgress extends StatelessWidget {
  final String text;

  const CustomCircularProgress({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: darkBlueColor),
          const SizedBox(width: 15),
          TitleH1(
            title: text,
            color: darkBlueColor,
          ),
        ],
      ),
    );
  }
}
