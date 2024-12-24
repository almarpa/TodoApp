import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/data/repository/user_repository.dart';
import 'package:todo_app/app/domain/model/task_model.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_bloc.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_event.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_state.dart';
import 'package:todo_app/app/presentation/screens/home/task_list.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/screens/home/task_list_placeholder.dart';
import 'package:todo_app/app/presentation/screens/sign_in/bloc/sign_in_event.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';
import '../../widgets/custom_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository userRepository;

  const HomeScreen(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => TaskBloc(userRepository: userRepository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: primary,
          actions: [
            IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(Icons.login),
            ),
          ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TasksLoaded) {
              return TaskList(
                state.tasks,
                onTaskDoneChange: (TaskModel task) =>
                    context.read<TaskBloc>().add(CheckTaskEvent(task)),
                onDeleteTask: (String taskId) =>
                    context.read<TaskBloc>().add(DeleteTaskEvent(taskId)),
              );
            } else if (state is Error) {
              return Center(child: Text(state.message));
            } else {
              return const TaskListPlaceholder();
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
      builder: (_) => BlocProvider.value(
        value: context.read<TaskBloc>(),
        child: CustomBottomSheet(onPressed: (taskDescription) {
          context
              .read<TaskBloc>()
              .add(AddTaskEvent(TaskModel.empty(taskDescription)));
          Navigator.of(context).pop();
        }),
      ),
    );
  }
}
