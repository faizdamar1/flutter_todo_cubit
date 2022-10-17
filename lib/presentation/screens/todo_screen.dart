import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/constants/string.dart';
import 'package:flutter_todo_cubit/cubit/todo/todo_cubit.dart';
import 'package:flutter_todo_cubit/data/models/todo_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, addTodoRoute);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is! TodoLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          // ignore: unnecessary_cast
          final todos = (state as TodoLoaded).todos;
          return SingleChildScrollView(
            child: Column(
              children: todos.map((e) => _todo(e)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _todo(TodoModel todo) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, editTodoRoute, arguments: todo);
      },
      child: Dismissible(
        key: Key("${todo.id}"),
        confirmDismiss: (_) async {
          context.read<TodoCubit>().changeCompletion(todo);
          return false;
        },
        background: Container(
          color: Colors.indigo,
        ),
        child: _todoTile(todo, context),
      ),
    );
  }

  Widget _todoTile(TodoModel todo, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo),
        ],
      ),
    );
  }

  Widget _completionIndicator(TodoModel todo) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 4.0,
          color: todo.isComplete ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
