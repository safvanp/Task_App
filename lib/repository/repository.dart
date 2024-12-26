import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_app/constants.dart';
import 'package:task_app/models/task.dart';

class TaskRepository {
  Future<List<Task>> getAllTask() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + getAllTaskEndPoint));
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((task) => Task.fromMap(task))
            .toList();
      } else {
        throw Exception("Failed");
      }
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }

  Future<List<String>> getAllEmployee() async {
    List<String> employees = [];
    try {
      final response =
          await http.get(Uri.parse(baseUrl + getAllEmployeeEndPoint));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        for (var emp in data) {
          employees.add(emp['name']);
        }
        return employees;
      } else {
        // throw Exception("Failed");
        return emptyList;
      }
    } catch (ex) {
      // throw Exception(ex.toString());
      return emptyList;
    }
  }

  Future<bool> addTaskData(Task task) async {
    bool ret = false;
    try {
      var data = jsonEncode(<String, dynamic>{
        "id": 0,
        "TaskName": task.name,
        "TaskDescription": task.description,
        "EmployeeName": task.employee
      });

      final response = await http.post(Uri.parse(baseUrl + addTaskEndPoint),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data);
      if (response.statusCode == 201) {
        ret = true;
      }
    } catch (ex) {
      // throw Exception(ex.toString());
    }
    return ret;
  }

  Future<bool> updateTaskData(Task task) async {
    bool ret = false;
    try {
      var data = jsonEncode(<String, dynamic>{
        "id": task.id,
        "TaskName": task.name,
        "TaskDescription": task.description,
        "EmployeeName": task.employee
      });
      final response =
          await http.put(Uri.parse('$baseUrl$updateTaskEndPoint${task.id}'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: data);
      if (response.statusCode == 200) {
        ret = true;
      }
    } catch (ex) {
      // throw Exception(ex.toString());
    }
    return ret;
  }

  Future<bool> deleteTaskData(Task task) async {
    bool ret = false;
    try {
      final response = await http
          .delete(Uri.parse('$baseUrl$deleteTaskEndPoint/${task.id}'));
      if (response.statusCode == 200) {
        ret = true;
      }
    } catch (ex) {
      // throw Exception(ex.toString());
    }
    return ret;
  }
}
