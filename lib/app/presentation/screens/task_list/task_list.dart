import 'package:todo_app/app/data/entities/task_entity.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList(this.tasks, {super.key, required this.onTaskDoneChange});

  final List<Task> tasks;
  final void Function(Task task) onTaskDoneChange;

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
                    itemBuilder: (context, index) =>
                        _TaskItem(tasks[index], onTap: () {
                          onTaskDoneChange(tasks[index]);
                        })))
          ],
        ));
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task, {required this.onTap});

  final Task task;
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
                    task.done
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                      child: Text(
                    task.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            )));
  }
}