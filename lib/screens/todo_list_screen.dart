import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/widgets/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoListProvider todoList = Provider.of<TodoListProvider>(context);
    final List<Todo> items = todoList.items;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.todoItem);
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Colors.transparent),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      appBar: AppBar(
        title: const Text('TODO APP'),
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
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView.builder(
          itemCount: todoList.itemsCount,
          itemBuilder: (context, index) => TodoItem(todo: items[index]),
        ),
      ),
    );
  }
}
