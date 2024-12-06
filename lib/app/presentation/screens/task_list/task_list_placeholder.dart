import 'package:flutter/material.dart';

class TaskListPlaceholder extends StatelessWidget {
  const TaskListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('No tasks added yet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
