import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/repository/repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TasksState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(const TasksLoaded()) {
    on<LoadTask>(_onLoadTask);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
  }

  Future<void> _onLoadTask(LoadTask event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      List<Task> tasks = await _taskRepository.getAllTask();
      emit(TasksLoaded(tasks: tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    final state = this.state;
    if (state is TasksLoaded) {
      bool status = await _taskRepository.addTaskData(event.task);
      if (status) {
        List<Task> tasks = await _taskRepository.getAllTask();
        emit(TasksLoaded(tasks: tasks));
      } else {
        emit(TasksLoaded(tasks: List.from(state.tasks)..add(event.task)));
      }
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    final state = this.state;
    if (state is TasksLoaded) {
      bool status = await _taskRepository.updateTaskData(event.task);
      if (status) {
        List<Task> tasks = await _taskRepository.getAllTask();
        emit(TasksLoaded(tasks: tasks));
      } else {
        List<Task> tasks = (state.tasks.map((task) {
          return task.id == event.task.id ? event.task : task;
        })).toList();
        emit(TasksLoaded(tasks: tasks));
      }
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    final state = this.state;
    if (state is TasksLoaded) {
      bool status = await _taskRepository.deleteTaskData(event.task);
      if (status) {
        List<Task> tasks = await _taskRepository.getAllTask();
        emit(TasksLoaded(tasks: tasks));
      } else {
        List<Task> tasks = state.tasks.where((task) {
          return task.id != event.task.id;
        }).toList();
        emit(TasksLoaded(tasks: tasks));
      }
    }
  }
}
