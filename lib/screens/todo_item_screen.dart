import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_item_form.dart';

class TodoItemScreen extends StatefulWidget {
  const TodoItemScreen({super.key});

  @override
  State<TodoItemScreen> createState() => _TodoItemScreenState();
}

class _TodoItemScreenState extends State<TodoItemScreen> {
  @override
  Widget build(BuildContext context) {
    final Todo? todoToEdit =
        ModalRoute.of(context)?.settings.arguments as Todo?;
    final bool isUpdate = todoToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? 'Atualizar tarefa' : 'Adicionar Tarefa',
        ),
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: TodoItemForm(
            todoToEdit: todoToEdit,
          ),
        ),
      ),
    );
  }
}
