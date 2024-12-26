import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Task {
  final int id;
  final String name;
  final String description;
  final String employee;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.employee,
  });

  Task copyWith({
    int? id,
    String? name,
    String? description,
    String? employee,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      employee: employee ?? this.employee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'employee': employee,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt() ?? 0,
      name: map['TaskName'] ?? '',
      description: map['TaskDescription'] ?? '',
      employee: map['EmployeeName'] ?? '',
    );
  }

  factory Task.fromJson(String source) => Task.fromMap(jsonDecode(source));

  @override
  String toString() {
    return 'Task(id: $id, name: $name, description: $description, employee: $employee)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.employee == employee;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        employee.hashCode;
  }
}

//   copyWith({int? id, int? description, String? name, bool? isComplete}) {
//     return Task(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         description: this.description);
//   }

//   factory Task.fromJson(Map<String, dynamic> json) => _TaskFromJson(json);
//   Map<String, dynamic> toJson() => _TaskToJson(this);
// }

// Task _TaskFromJson(Map<String, dynamic> json) => Task(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       description: json['description'] as String,
//     );

// Map<String, dynamic> _TaskToJson(Task instance) => <String, dynamic>{
//       'id': instance.id,
//       'name': instance.name,
//       'description': instance.description
//     };
