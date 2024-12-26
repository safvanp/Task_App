import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 100, 73, 192);
const baseUrl = "http://192.168.70.109:86/";
const getAllTaskEndPoint = "api/Task"; //GET api/Task - GET api/Task/{id}
const getAllEmployeeEndPoint =
    "api/Employee"; //GET api/Employee - GET api/Employee/{id}
const addTaskEndPoint = "api/Task"; //POST api/Task
const updateTaskEndPoint = "api/Task/"; //PUT api/Task/{id}
const deleteTaskEndPoint = "api/Task/"; //DELETE api/Task/{id}
const emptyList = ['Employee 1', 'Employee 2', 'Employee 3'];
int currentId = 0;
