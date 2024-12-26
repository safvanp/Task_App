import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Widget/task_widget.dart';
import 'package:task_app/bloc/task_bloc.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/repository/repository.dart';
import 'package:task_app/screens/edit_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskRepository _taskRepository = TaskRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Task',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocProvider(
        create: (context) => TaskBloc(_taskRepository)..add(const LoadTask()),
        child: BlocBuilder<TaskBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksLoading) {
              return const CircularProgressIndicator();
            }
            if (state is TasksLoaded) {
              currentId = state.tasks.length;
              return currentId == 0
                  ? const Center(child: Text('No Task Found'))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ...state.tasks.map(
                              (task) => InkWell(
                                onTap: (() async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditTask(task: task),
                                      ));
                                }),
                                child: TaskWidget(
                                  task: task,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    );
            } else {
              return const Text('No Task Found');
            }
          },
        ),
      ),
      floatingActionButton: BlocListener<TaskBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Task Updated'),
            ));
          }
        },
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.black,
          onPressed: () async {
            Navigator.pushNamed(context, '/create');
          },
          tooltip: 'New Task',
          child: const Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
