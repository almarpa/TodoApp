import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';
import 'package:todo_app/app/presentation/home/TaskList.dart';
import 'package:todo_app/app/domain/model/Task.dart';
import '../components/TaskModal.dart';
import '../components/TextTitle.dart';
import 'TaskListPlaceholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [
    Task("Prueba 1 "),
    Task("Prueba 2 Prueba 2 Prueba"),
    Task("Prueba 3 Prueba 3 Prueba 3 Prueba 3 Prueba 3 Prueba 3"),
  ];

  void _showNewTaskModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => TaskModal(onAcceptPressed: (Task task) {
              _addTask(task);
            }));
  }

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle("Task List"),
        backgroundColor: primary,
      ),
      body: tasks.isEmpty
          ? const TaskListPlaceholder()
          : TaskList(
              tasks,
              onTaskDoneChange: (Task task) {
                print(task.done);
                setState(() {
                  task.done = !task.done;
                });
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewTaskModal,
        backgroundColor: primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
