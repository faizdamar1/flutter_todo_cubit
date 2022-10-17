import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

void main() async {
  final data = await TodoServices().fetchTodos();
  inspect(data);
}

class TodoServices {
  final baseUrl = "http://192.168.0.8:3000";

  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse("$baseUrl/todos"));
      if (kDebugMode) {
        print(response.body);
      }
      return jsonDecode(response.body) as List;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await patch(Uri.parse("$baseUrl/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map?> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await post(Uri.parse("$baseUrl/todos"), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await delete(Uri.parse("$baseUrl/todos/$id"));
      return true;
    } catch (er) {
      return false;
    }
  }
}
