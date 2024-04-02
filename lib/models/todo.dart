import 'dart:math';

import 'package:todo_app/models/todo_form.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.completed = false,
  });

  String? validate() {
    String? titleError = validateTitle(title);
    if (titleError != null) {
      return titleError;
    }
    String? descriptionError = validateDescription(description);
    if (descriptionError != null) {
      return descriptionError;
    }

    return null;
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

  static Todo from(TodoForm todoForm) {
    return Todo(
        id: Random().nextDouble().toString(),
        title: todoForm.title,
        description: todoForm.description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
  }
}
