import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/todo_repository_sqlite.dart';

class TodoListProvider with ChangeNotifier {
  List<Todo> _items = [];

  List<Todo> get items => [..._items];

  Future<void> filterCompletedItems() async {
    final items = await TodoRepositorySqlite.getAllCompleted();
    _items = items.map((item) => Todo.fromSQLite(item)).toList();
    _mapSQLiteToList(items);
  }

  Future<void> allItems() async {
    final items = await TodoRepositorySqlite.getAll();
    _mapSQLiteToList(items);
  }

  Future<void> add(Todo todo) async {
    _items.insert(0, todo);
    await TodoRepositorySqlite.insert(Todo.toSQLite(todo));
    notifyListeners();
  }

  Future<void> partialUpdate(Todo newTodo) async {
    int todoIndex = _findIndexTodo(newTodo.id);
    Todo oldTodo = _items[todoIndex];
    if (todoIndex >= 0) {
      _items[todoIndex] = Todo(
        id: newTodo.id,
        title: newTodo.title,
        description: newTodo.description,
        createdAt: oldTodo.createdAt,
        updatedAt: DateTime.now(),
      );
      await TodoRepositorySqlite.insert(Todo.toSQLite(newTodo));
      notifyListeners();
    }
  }

  Future<void> toggleCompleted(String id) async {
    int todoIndex = _findIndexTodo(id);
    if (todoIndex >= 0) {
      _items[todoIndex].completed = !_items[todoIndex].completed;
      await TodoRepositorySqlite.insert(Todo.toSQLite(_items[todoIndex]));
      notifyListeners();
    }
  }

  int _findIndexTodo(String id) {
    int todoIndex = -1;
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        todoIndex = i;
      }
    }

    return todoIndex;
  }

  Future<void> remove(String todoId) async {
    await TodoRepositorySqlite.remove(todoId);
    _items.removeWhere((element) => element.id == todoId);
    notifyListeners();
  }

  void _mapSQLiteToList(List<Map<String, dynamic>> items) {
    _items = items.map((item) => Todo.fromSQLite(item)).toList();
  }
}
