// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_todo_cubit/cubit/todo/todo_cubit.dart';
import 'package:flutter_todo_cubit/data/models/todo_model.dart';
import 'package:flutter_todo_cubit/data/todo_repository.dart';

part 'edit_todo_state.dart';

class TodoEditData extends Cubit<TodoModel> {
  TodoModel data = TodoModel(todoMessage: "", isComplete: false, id: 0);
  TodoEditData({required this.data}) : super(data);

  void editData(TodoModel todo) {
    emit(TodoModel(
        todoMessage: todo.todoMessage,
        isComplete: todo.isComplete,
        id: todo.id));
  }
}

class EditTodoCubit extends Cubit<EditTodoState> {
  final TodoRepository todoRepository;
  final TodoCubit todoCubit;

  EditTodoCubit({required this.todoRepository, required this.todoCubit})
      : super(EditTodoInitial());

  void deleteTodo(TodoModel todo) {
    todoRepository.deleteTodo(todo.id).then((isDeleted) {
      if (isDeleted) {
        todoCubit.deleteTodo(todo);

        emit(TodoEdited());
      }
    });
  }

  void updateTodo(TodoModel todo, String message) {
    if (kDebugMode) {
      print(message);
    }
    if (message.isEmpty) {
      emit(EditTodoError(error: "Message is empty"));
      return;
    }

    todoRepository.updateTodo(message, todo.id).then((isEdited) {
      if (isEdited) {
        todo.todoMessage = message;
        todoCubit.updateTodoList();
        emit(TodoEdited());
      }
    });
  }
}
