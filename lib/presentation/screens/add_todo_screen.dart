import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final _controller = TextEditingController();

  AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
          } else if (state is AddTodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: const InputDecoration(hintText: "Enter todo message..."),
        ),
        const SizedBox(height: 10.0),
        InkWell(
          onTap: () {
            final message = _controller.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
          child: _addBtn(context),
        )
      ],
    );
  }

  Widget _addBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) return const CircularProgressIndicator();

            return const Text(
              "Add Todo",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
