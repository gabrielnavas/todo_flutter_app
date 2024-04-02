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
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 17),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: ListTile(
        trailing: _trailingActions(width),
        title: _title(),
        subtitle: _subtitle(),
        onTap: () {},
      ),
    );
  }

  Text _subtitle() {
    return Text(
      todo.description,
      style: const TextStyle(
          fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w400),
    );
  }

  Text _title() {
    return Text(
      todo.title,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  SizedBox _trailingActions(double widthScreen) {
    const double iconSize = 25.0;
    const double spaceBetweenIcons = 10.0;
    final widthSizedBox = widthScreen * .40;

    return SizedBox(
      width: widthSizedBox,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              size: iconSize,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => const Color.fromARGB(25, 193, 193, 193),
              ),
            ),
          ),
          const SizedBox(
            width: spaceBetweenIcons,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.remove_circle_outline_outlined,
              size: iconSize,
            ),
          ),
          const SizedBox(
            width: spaceBetweenIcons,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
