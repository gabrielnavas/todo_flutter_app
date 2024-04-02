import 'package:flutter/material.dart';

class TodoItemScreen extends StatefulWidget {
  const TodoItemScreen({super.key});

  @override
  State<TodoItemScreen> createState() => _TodoItemScreenState();
}

class _TodoItemScreenState extends State<TodoItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
        actions: const [
          Icon(
            Icons.date_range,
            size: 30,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
