import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:flutter_todo_cubit/cubit/todo/todo_cubit.dart';
import 'package:flutter_todo_cubit/data/todo_repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final TodoRepository todoRepository;
  final TodoCubit todoCubit;

  AddTodoCubit({required this.todoRepository, required this.todoCubit})
      : super(AddTodoInitial());
  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(error: "todo message is empty"));
      return;
    }

    emit(AddingTodo());
    Timer(const Duration(seconds: 2), () {
      todoRepository.addTodo(message).then((todo) {
        if (todo != null) {
          todoCubit.addTodo(todo);
          emit(TodoAdded());
        }
      });
    });
  }
}
