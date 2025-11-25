import 'package:flutter/material.dart';
import 'package:taskmaster/todo_list_page.dart';

void main() {
  runApp(const TaskMasterApp());
}

class TaskMasterApp extends StatelessWidget {
  const TaskMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Task Master',
      theme : ThemeData(primarySwatch: Colors.blue),
      home: TodoListPage(),
    );
  }
}