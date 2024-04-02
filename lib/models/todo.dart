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
}
