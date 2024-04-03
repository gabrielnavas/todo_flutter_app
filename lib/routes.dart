import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_list_screen.dart';
import 'package:todo_app/screens/todo_item_screen.dart';

class Routes {
  static const String todoList = "todo_list";
  static const String todoItem = "todo_item";

  static Map<String, Widget Function(BuildContext)> routes() {
    return {
      todoList: (_) => const TodoListScreen(),
      todoItem: (_) => const TodoItemScreen(),
    };
  }
}
