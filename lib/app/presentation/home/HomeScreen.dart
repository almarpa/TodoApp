import 'package:flutter/material.dart';
import 'package:todo_app/app/data/repository/TaskRepository.dart';
import 'package:todo_app/app/data/repository/impl/TaskRepositoryImpl.dart';
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
  final TaskRepository taskRepository = TaskRepositoryImpl();

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
      taskRepository.addTask(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle("Task List"),
        backgroundColor: primary,
      ),
      body: FutureBuilder<List<Task>>(
        future: taskRepository.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.isEmpty == true) {
            return const TaskListPlaceholder();
          } else {
            return TaskList(
              snapshot.data!,
              onTaskDoneChange: (Task task) {
                taskRepository.saveTasks(snapshot.data!);
                task.done = !task.done;
                setState(() {});
              },
            );
          }
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
