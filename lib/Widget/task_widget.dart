import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/bloc/task_bloc.dart';
import 'package:task_app/models/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TasksState>(
      listener: (context, state) {},
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(task.description,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
                Text('employee :${task.employee}',
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500))
              ]),
        ),
      ),
    );
  }
}
