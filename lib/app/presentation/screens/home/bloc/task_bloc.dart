import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/data/repository/task_repository.dart';
import 'package:todo_app/app/domain/model/task_model.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_event.dart';
import 'package:todo_app/app/presentation/screens/home/bloc/task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  late final StreamSubscription<List<TaskModel>> tasksStream;

  TaskBloc(this.taskRepository) : super(Loading()) {
    tasksStream =
        taskRepository.tasks.listen((tasks) => add(TasksLoadedEvent(tasks)));

    on<CheckTaskEvent>(_onTaskDone);
    on<TasksLoadedEvent>(_onTasksUpdated);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onTaskDone(CheckTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.checkTask(event.task);
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  void _onTasksUpdated(TasksLoadedEvent event, Emitter<TaskState> emit) {
    emit(TasksLoaded(event.tasks));
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.addTask(event.task);
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.deleteTask(event.taskId);
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
