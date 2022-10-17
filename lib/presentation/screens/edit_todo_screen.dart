import 'package:flutter/material.dart';

class EditTodoScreen extends StatelessWidget {
  const EditTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo App"),
      ),
      body: const Center(
        child: Text("Add Todo"),
      ),
    );
  }
}
