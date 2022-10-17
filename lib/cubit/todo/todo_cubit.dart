// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_todo_cubit/data/models/todo_model.dart';
import 'package:flutter_todo_cubit/data/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;
  TodoCubit({required this.todoRepository}) : super(TodoInitial());

  void fetchTodos() {
    todoRepository.fetchTodo().then(
          (value) => emit(
            TodoLoaded(todos: value),
          ),
        );
  }

  void changeCompletion(TodoModel todo) {
    todoRepository
        .changeCompletion(!todo.isComplete, todo.id)
        .then((isChanged) {
      if (isChanged) {
        todo.isComplete = !todo.isComplete;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodoLoaded) {
      emit(TodoLoaded(todos: currentState.todos));
    }
  }

  addTodo(TodoModel todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodoLoaded(todos: todoList));
    }
  }

  void deleteTodo(TodoModel todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodoLoaded(todos: todoList));
    }
  }
}
