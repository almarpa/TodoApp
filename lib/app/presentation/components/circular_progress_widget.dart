import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CircularProgressWidget extends StatefulWidget {
  final String text;

  const CircularProgressWidget({super.key, required this.text});

  @override
  _CircularProgressWidgetState createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget> {
  @override
  void initState() {
    super.initState();
    // Retrasar la finalización de la tarea durante 3 segundos
    Future.delayed(const Duration(seconds: 1), () {
      // Notificar a la aplicación que la tarea ha finalizado
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: darkBlueColor),
          const SizedBox(width: 15),
          Text(
            widget.text,
            style: const TextStyle(
              fontFamily: "MonB",
              color: darkBlueColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}