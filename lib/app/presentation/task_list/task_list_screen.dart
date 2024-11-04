import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/task_list/task_list.dart';
import 'package:todo_app/app/presentation/task_list/task_list_placeholder.dart';
import 'package:todo_app/app/presentation/task_list/task_provider.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';
import 'package:todo_app/app/domain/model/Task.dart';
import '../components/TaskModal.dart';
import '../components/TextTitle.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..fetchTasks(),
      child: Scaffold(
        appBar: AppBar(
          title: const TextTitle("Task List"),
          backgroundColor: primary,
        ),
        body: Consumer<TaskProvider>(
          builder: (_, provider, __) {
            if (provider.taskList.isEmpty) {
              return const TaskListPlaceholder();
            } else {
              return TaskList(
                provider.taskList,
                onTaskDoneChange: (Task task) {
                  provider.onTaskDoneChange(task);
                },
              );
            }
          },
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => _showNewTaskModal(context),
            backgroundColor: primary,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
              value: context.read<TaskProvider>(),
              child: const TaskModal(),
            ));
  }
}
