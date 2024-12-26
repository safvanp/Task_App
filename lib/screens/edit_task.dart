import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_app/bloc/task_bloc.dart';
import 'package:task_app/constants.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/repository/repository.dart';

class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({
    super.key,
    required this.task,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedEmployee;
  final TaskRepository repository = TaskRepository();
  List<String> employees = [];
  late Task selectedTask;

  @override
  void initState() {
    selectedTask = widget.task;
    nameController.text = selectedTask.name;
    descriptionController.text = selectedTask.description;
    selectedEmployee = selectedTask.employee;

    super.initState();
    repository.getAllEmployee().then(
      (value) {
        setState(() {
          employees.addAll(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Create Task'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Task name is required';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedEmployee,
              decoration: const InputDecoration(
                labelText: 'Employee Name',
                border: OutlineInputBorder(),
              ),
              items: employees
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => selectedEmployee = value),
              validator: (value) =>
                  value == null ? 'Please select an employee' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    selectedEmployee != null) {
                  Task task = Task(
                      id: selectedTask.id,
                      name: nameController.text,
                      description: descriptionController.text,
                      employee: selectedEmployee!);
                  context.read<TaskBloc>().add(UpdateTask(task: task));
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Update Task',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    selectedEmployee != null) {
                  Task task = Task(
                      id: selectedTask.id,
                      name: nameController.text,
                      description: descriptionController.text,
                      employee: selectedEmployee!);
                  context.read<TaskBloc>().add(DeleteTask(task: task));
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Delete Task',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
