import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 25.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 17),
      child: ListTile(
        trailing: const SizedBox(
          width: 110,
          child: Row(
            children: [
              Icon(
                Icons.edit_outlined,
                size: iconSize,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.remove_circle_outline_outlined,
                size: iconSize,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.check_circle_outline_outlined,
                size: iconSize,
              )
            ],
          ),
        ),
        title: Text(
          todo.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          todo.description,
          style: const TextStyle(
              fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        onTap: () {},
      ),
    );
  }
}
