import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_list_data.dart';
import 'package:todo_app/models/todo.dart';

class TodoListProvider with ChangeNotifier {
  final List<Todo> _items = [...TodoListData.data];

  int get itemsCount => _items.length;
  List<Todo> get items => [..._items];

  void add(Todo todo) {
    _items.insert(0, todo);
    notifyListeners();
  }

  void partialUpdate(Todo newTodo) {
    int todoIndex = findIndexTodo(newTodo.id);
    Todo oldTodo = _items[todoIndex];
    if (todoIndex >= 0) {
      _items[todoIndex] = Todo(
        id: newTodo.id,
        title: newTodo.title,
        description: newTodo.description,
        createdAt: oldTodo.createdAt,
        updatedAt: DateTime.now(),
      );
    }
    notifyListeners();
  }

  void toggleCompleted(String id) {
    int todoIndex = findIndexTodo(id);
    if (todoIndex >= 0) {
      _items[todoIndex].completed = !_items[todoIndex].completed;
    }
  }

  int findIndexTodo(String id) {
    int todoIndex = -1;
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        todoIndex = i;
      }
    }

    return todoIndex;
  }

  void remove(String id) {
    _items.removeWhere((element) => element.id == id);
  }
}
