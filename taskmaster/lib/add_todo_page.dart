import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // fungsi untuk add todo 
  Future<void> addTodo() async{
    String title = _titleController.text;
    String description = _descriptionController.text;
    bool completed = false;

    if(title.isNotEmpty && description.isNotEmpty) {
      final response = await http.post(Uri.parse('http://localhost:3000/todos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          'title' : title,
          'description' : description,
          'completed': completed
        }));

      if (response.statusCode == 201) {
        Navigator.pop(context);
      }
      else{
        throw Exception('Failed to create item');
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('tambah Item')),
      body: Padding(
        padding : const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul')),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi')),

            SizedBox(height: 20),
            ElevatedButton(onPressed: addTodo, child: Text('Simpan'))
          ],
        ),
      ),
    );
  }
}