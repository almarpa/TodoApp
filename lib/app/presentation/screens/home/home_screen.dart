import 'package:provider/provider.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/screens/home/task_list.dart';
import 'package:todo_app/app/presentation/screens/home/task_list_placeholder.dart';
import 'package:todo_app/app/presentation/screens/home/task_provider.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';
import 'package:todo_app/app/data/entities/task_entity.dart';
import '../../widgets/custom_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TaskProvider()..fetchTasks(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            backgroundColor: primary,
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  },
                  icon: const Icon(Icons.login))
            ],
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
        ));
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
              value: context.read<TaskProvider>(),
              child: const CustomBottomSheet(),
            ));
  }
}
