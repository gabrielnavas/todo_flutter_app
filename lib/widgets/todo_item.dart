import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/widgets/snack_message.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final date = isUpdate() ? todo.updatedAt : todo.createdAt;

    String formattedDateTime =
        DateFormat('dd-MM-yyyy \'às\' HH:mm:ss').format(date);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 17.5),
          trailing: _trailingActions(
            context,
            width,
          ),
          title: _title(context),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _subtitle(context),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.update,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formattedDateTime,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 10.5,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              )
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }

  bool isUpdate() {
    return todo.createdAt.year != todo.updatedAt.year ||
        todo.createdAt.month != todo.updatedAt.month ||
        todo.createdAt.day != todo.updatedAt.day ||
        todo.createdAt.hour != todo.updatedAt.hour ||
        todo.createdAt.minute != todo.updatedAt.minute ||
        todo.createdAt.second != todo.updatedAt.second;
  }

  bool isCompleted() {
    return todo.completed;
  }

  Text _subtitle(BuildContext context) {
    return Text(
      todo.description,
      style: todo.completed
          ? subtitleCompleted(context)
          : subtitleNotCompleted(context),
    );
  }

  TextStyle subtitleCompleted(BuildContext context) {
    return TextStyle(
      fontSize: 17,
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.lineThrough,
      decorationColor: Theme.of(context).colorScheme.primary,
    );
  }

  TextStyle subtitleNotCompleted(BuildContext context) {
    return TextStyle(
      fontSize: 17,
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w500,
    );
  }

  Text _title(BuildContext context) {
    return Text(
      todo.title,
      style: todo.completed ? _titleCompleted(context) : _titleNotCompleted(),
    );
  }

  TextStyle _titleNotCompleted() {
    return const TextStyle(
      fontSize: 20,
    );
  }

  TextStyle _titleCompleted(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.lineThrough,
      decorationColor: Theme.of(context).colorScheme.primary,
    );
  }

  SizedBox _trailingActions(BuildContext context, double widthScreen) {
    const double iconSize = 25.0;
    const double spaceBetweenIcons = 10.0;
    final widthSizedBox = widthScreen * .40;

    return SizedBox(
      width: widthSizedBox,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isCompleted())
            IconButton(
              onPressed: () => _editTodoItem(context, todo),
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
            onPressed: () => _removeTodoItem(context, todo.id),
            icon: const Icon(
              Icons.remove_circle_outline_outlined,
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
            onPressed: () => _toggleCompleted(context, todo.id),
            icon: Icon(
              Icons.check_circle_outline_outlined,
              size: iconSize,
              color: todo.completed
                  ? Colors.green
                  : Theme.of(context).colorScheme.onSecondary,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => const Color.fromARGB(25, 193, 193, 193),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editTodoItem(final BuildContext context, final Todo todo) {
    Navigator.of(context)
        .pushNamed(
          Routes.todoItem,
          arguments: todo,
        )
        .then((_) => SnackMessage.show(context, 'Tarefa editada!'));
  }

  void _toggleCompleted(final BuildContext context, final String todoId) {
    Provider.of<TodoListProvider>(context, listen: false)
        .toggleCompleted(todoId)
        .then(
      (_) {
        if (todo.completed) {
          SnackMessage.show(context, 'Tarefa concluída!');
        } else {
          SnackMessage.show(context, 'Tarefa em andamento!');
        }
      },
    );
  }

  _removeTodoItem(BuildContext context, String todoId) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Theme.of(context).colorScheme.onSecondary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Deseja remover essa tarefa?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      child: Text(
                        'Sim',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Provider.of<TodoListProvider>(context, listen: false)
                            .remove(todoId);

                        Navigator.pop(context);
                        SnackMessage.show(context, 'Tarefa removida');
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: Text(
                        'Não',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
