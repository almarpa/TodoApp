import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key, required this.onAcceptPressed});

  final String onAcceptPressed;

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  String description = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: TextField(
        onChanged: (value) {
          description = value;
        },
        decoration: const InputDecoration(hintText: 'Enter task description'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onAcceptPressed;
            Navigator.of(context).pop();
          },
          child: const Text('Accept'),
        ),
      ],
    );
  }
}
