import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_app/app/data/repository/user_repository.dart';
import 'package:todo_app/app/domain/model/task_model.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_event.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final UserRepository userRepository;
  late final StreamSubscription<List<TaskModel>> tasksStream;

  TaskBloc({required this.userRepository}) : super(Loading()) {
    tasksStream =
        userRepository.tasks.listen((tasks) => add(TasksUpdatedEvent(tasks)));

    on<CheckTaskEvent>(_onTaskDone);
    on<TasksUpdatedEvent>(_onTaskUpdated);
    on<AddTaskEvent>(_onAddTask);
  }

  void _onTaskDone(CheckTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await userRepository.checkTask(event.task);
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  void _onTaskUpdated(TasksUpdatedEvent event, Emitter<TaskState> emit) {
    emit(TasksLoaded(event.tasks));
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await userRepository.addTask(event.task);
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    tasksStream.cancel();
    return super.close();
  }
}
