import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taskmaster/add_todo_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage>{
  List<Map<String, dynamic>> todos = [];

  @override
  void initState(){
    super.initState();
    fetchTodos();
  }
  

  Future<void> fetchTodos() async{
    final response = await http.get(Uri.parse('http://localhost:3000/todos'));

    if (response.statusCode == 200) {
      setState(() {
        todos = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    }
    else{
      throw Exception('Failed to Load todos');
    }
  }

  void _addTodo() async{
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoPage()),
      );

      fetchTodos();
  }

  void toggleCompleted(int index) async{
    var todo = todos[index];
    final response = await http.patch(Uri.parse('http://localhost:3000/todos/${todo['id']}/toggle'));

    if(response.statusCode == 200) {
      setState(() {
        todos[index]['completed'] = !todos[index]['completed'];
      });
    }
      else {
        throw Exception('Failed to toggle item');
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
          var todo = todos[index];
          return ListTile(
            title : Text(todo['title']),
            trailing: Icon(
              todo['completed'] 
              ? Icons.check_circle
              : Icons.check_outlined,
              color: todo['completed'] 
              ? Colors.green 
              : Colors.grey,
              ),
              onTap: () => toggleCompleted(index),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'tambah todo',
        child: const Icon(Icons.add)
        ),
    );
  }
}