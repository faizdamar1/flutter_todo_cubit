import 'package:flutter/material.dart';
import 'package:flutter_todo_cubit/constants/string.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, addTodoRoute);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: const Center(),
    );
  }
}
