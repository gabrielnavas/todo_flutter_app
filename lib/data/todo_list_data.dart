import 'package:todo_app/models/todo.dart';

class TodoListData {
  static final List<Todo> data = [
    Todo(
      id: '1',
      title: 'Test 1',
      description: 'blablal',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Todo(
      id: '2',
      title: 'Test 2',
      description: 'blablal',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      completed: true,
    ),
    Todo(
      id: '3',
      title: 'Test 3',
      description: 'blablal',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      completed: false,
    ),
    Todo(
        id: '4',
        title: 'Test 4',
        description: 'blablal',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    Todo(
        id: '5',
        title: 'Test 5',
        description: 'blablal',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    Todo(
      id: '6',
      title: 'Test 6',
      description: 'blablal',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      completed: true,
    ),
    Todo(
        id: '7',
        title: 'Test 7',
        description: 'blablal',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    Todo(
        id: '8',
        title: 'Test 8',
        description: 'blablal',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    Todo(
      id: '9',
      title: 'Test 9',
      description: 'blablal',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      completed: true,
    ),
  ];
}
