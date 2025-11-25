import 'dart:convert';

import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage>{
  List<Map<String, dynamic>> todos = [];

  Future<void> fetchTodos() async{
    final response = await http.get(Uri.parse('http://localhost/3000/todos'));

    if (response.StatusCode == 200) {
      setState(() {
        todos = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    }
    else{
      throw Exception('Failed to Load todos');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskMaster - TodoList'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: todos.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context,index){
          return ListTile(title : Text('Item'));
          },
        ),
    );
  }
}