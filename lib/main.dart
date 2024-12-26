import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/bloc/task_bloc.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/repository/repository.dart';
import 'package:task_app/screens/create_task.dart';
import 'package:task_app/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskRepository _taskRepository = TaskRepository();
    return BlocProvider(
      create: (context) => TaskBloc(_taskRepository),
      child: MaterialApp(
        title: 'Task App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        routes: {
          '/': (context) => const HomePage(),
          '/create': (context) => const CreateTask()
        },
      ),
    );
  }
}
