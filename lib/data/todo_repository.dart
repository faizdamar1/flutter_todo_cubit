import 'package:flutter_todo_cubit/data/models/todo_model.dart';
import 'package:flutter_todo_cubit/data/todo_services.dart';

class TodoRepository {
  final TodoServices todoServices;

  TodoRepository({required this.todoServices});

  Future<List<TodoModel>> fetchTodo() async {
    final todosRaw = await todoServices.fetchTodos();
    return todosRaw.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isComplete, int id) async {
    final data = {"isComplete": isComplete.toString()};
    return await todoServices.patchTodo(data, id);
  }

  Future<TodoModel?> addTodo(String todo) async {
    final data = {"todo": todo, "isComplete": "false"};
    final todoMap = await todoServices.addTodo(data);
    if (todoMap == null) return null;

    return TodoModel.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await todoServices.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    final patchObj = {"todo": message};
    return await todoServices.patchTodo(patchObj, id);
  }
}
