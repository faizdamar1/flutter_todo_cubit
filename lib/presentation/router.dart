import 'package:flutter/material.dart';
import 'package:flutter_todo_cubit/constants/string.dart';
import 'package:flutter_todo_cubit/presentation/screens/add_todo_screen.dart';
import 'package:flutter_todo_cubit/presentation/screens/edit_todo_screen.dart';
import 'package:flutter_todo_cubit/presentation/screens/todo_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialTodoRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const TodoScreen();
          },
        );

      case addTodoRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const AddTodoScreen();
          },
        );

      case editTodoRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const EditTodoScreen();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const AddTodoScreen();
          },
        );
    }
  }
}
