import 'package:flutter/material.dart';
import 'package:todo_app/app/domain/model/task_model.dart';
import 'package:todo_app/app/presentation/theme/colors.dart';

class TaskList extends StatelessWidget {
  const TaskList(this.tasks,
      {super.key, required this.onTaskDoneChange, required this.onDeleteTask});

  final List<TaskModel> tasks;
  final void Function(TaskModel task) onTaskDoneChange;
  final void Function(String taskId) onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => Dismissible(
                          key: Key(tasks[index].uuid),
                          onDismissed: (direction) {
                            onDeleteTask(tasks[index].uuid);
                          },
                          background: Container(
                            color: Theme.of(context).colorScheme.error,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete, color: white),
                          ),
                          direction: DismissDirection.endToStart,
                          child: _TaskItem(tasks[index], onTap: () {
                            onTaskDoneChange(tasks[index]);
                          }),
                        )))
          ],
        ));
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task, {required this.onTap});

  final TaskModel task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    task.isDone
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                      child: Text(
                    task.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            )));
  }
}
