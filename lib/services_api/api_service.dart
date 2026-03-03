import '../models/todo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String url = "https://jsonplaceholder.typicode.com/posts";

  // GET all TODOs
  static Future<List<Todo>> getTodos() async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      return data.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch todos");
    }
  }

  // POST TODO
  static Future addTodo(Todo todo) async {
    await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
  }

  // PUT TODO
  static Future updateTodo(int id, Todo todo) async {
    await http.put(
      Uri.parse("$url/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
  }

  // DELETE TODO
  static Future deleteTodo(int id) async {
    await http.delete(Uri.parse("$url/$id"));
  }
}