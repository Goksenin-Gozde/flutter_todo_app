import 'package:flutter/material.dart';
import 'todo_list.dart';


void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Todo List', home: TodoList());
  }
}


