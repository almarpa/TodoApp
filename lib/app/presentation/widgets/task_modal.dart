import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/presentation/widgets/text_title.dart';
import 'package:todo_app/app/presentation/screens/home/task_provider.dart';

import '../../data/entities/task_entity.dart';

class TaskModal extends StatefulWidget {
  const TaskModal({super.key});

  @override
  State<TaskModal> createState() => _TaskModalState();
}

class _TaskModalState extends State<TaskModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply keyboard height as padding to do not hide modal during keyboard is active
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        bottom: keyboardHeight,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextTitle("New task"),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  hintText: "Description"),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final task = Task(_controller.text);
                  context.read<TaskProvider>().addNewTask(task);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Accept"),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
