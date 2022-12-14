import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/constants/string.dart';
import 'package:flutter_todo_cubit/cubit/todo/add_todo_cubit.dart';
import 'package:flutter_todo_cubit/cubit/todo/edit_todo_cubit.dart';
import 'package:flutter_todo_cubit/cubit/todo/todo_cubit.dart';
import 'package:flutter_todo_cubit/data/models/todo_model.dart';
import 'package:flutter_todo_cubit/data/todo_repository.dart';
import 'package:flutter_todo_cubit/data/todo_services.dart';
import 'package:flutter_todo_cubit/presentation/screens/add_todo_screen.dart';
import 'package:flutter_todo_cubit/presentation/screens/edit_todo_screen.dart';
import 'package:flutter_todo_cubit/presentation/screens/todo_screen.dart';

class AppRouter {
  late TodoRepository todoRepository;
  late TodoCubit todoCubit;

  AppRouter() {
    todoRepository = TodoRepository(todoServices: TodoServices());
    todoCubit = TodoCubit(todoRepository: todoRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialTodoRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => todoCubit,
              child: const TodoScreen(),
            );
          },
        );

      case addTodoRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => AddTodoCubit(
                  todoRepository: todoRepository, todoCubit: todoCubit),
              child: AddTodoScreen(),
            );
          },
        );

      case editTodoRoute:
        final todo = settings.arguments as TodoModel;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => EditTodoCubit(
                  todoRepository: todoRepository, todoCubit: todoCubit),
              child: EditTodoScreen(
                todo: todo,
              ),
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return AddTodoScreen();
          },
        );
    }
  }
}
