import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services_api/api_service.dart';
import '../widgets/todo_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todos = [];
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future fetchTodos() async {
    final data = await Api.getTodos();
    setState(() => todos = data);
  }

  Future addTodo() async {
    final todo = Todo(title: titleCtrl.text, description: descCtrl.text);
    await Api.addTodo(todo);
    titleCtrl.clear();
    descCtrl.clear();
    fetchTodos();
  }

  Future updateTodo(Todo todo) async {
    final updated = Todo(title: todo.title + " (updated)", description: todo.description);
    await Api.updateTodo(todo.id!, updated);
    fetchTodos();
  }

  Future deleteTodo(Todo todo) async {
    await Api.deleteTodo(todo.id!);
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My TaskFlow TODO")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Title")),
                TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Description")),
                ElevatedButton(onPressed: addTodo, child: const Text("Add TODO")),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final t = todos[index];
                return TodoCard(
                  todo: t,
                  onEdit: () => updateTodo(t),
                  onDelete: () => deleteTodo(t),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}