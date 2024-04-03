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
  ];
}
