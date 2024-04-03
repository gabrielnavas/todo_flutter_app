import 'dart:math';

class Todo {
  final String id;
  String title;
  String description;
  final DateTime createdAt;
  DateTime updatedAt;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.completed = false,
  });

  static Todo titleDescription({
    String title = '',
    String description = '',
  }) {
    return Todo(
        id: Random().nextDouble().toString(),
        title: title,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
  }

  static Todo fromSQLite(Map<String, dynamic> todoMap) {
    return Todo(
      id: todoMap["id"] as String,
      title: todoMap["title"] as String,
      description: todoMap["description"] as String,
      completed: (todoMap["completed"] as int) == 1,
      createdAt: DateTime.parse(todoMap["created_at"] as String),
      updatedAt: DateTime.parse(todoMap["updated_at"] as String),
    );
  }

  static Map<String, Object> toSQLite(Todo todo) {
    return {
      "id": todo.id,
      "title": todo.title,
      "description": todo.description,
      "completed": todo.completed ? 1 : 0,
      "created_at": todo.createdAt.toIso8601String(),
      "updated_at": todo.updatedAt.toIso8601String(),
    };
  }

  static String? validateDescription(String description) {
    if (description.isEmpty) {
      return "Descrição deve ter no mínimo 1 caractere";
    }
    if (description.length > 100) {
      return "Descrição deve ter no máximo 100 caracteres";
    }

    return null;
  }

  static String? validateTitle(String title) {
    if (title.isEmpty) {
      return "Título deve ter no mínimo 1 caractere";
    }
    if (title.length > 100) {
      return "Título deve ter no máximo 100 caracteres";
    }

    return null;
  }
}
