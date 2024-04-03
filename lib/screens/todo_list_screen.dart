import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/widgets/todo_item.dart';

enum MenuBottomSelection { all, completed }

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  MenuBottomSelection menuBottomIndex = MenuBottomSelection.all;

  @override
  void initState() {
    super.initState();
    final TodoListProvider todoList = Provider.of<TodoListProvider>(
      context,
      listen: false,
    );
    if (menuBottomIndex == MenuBottomSelection.completed) {
      todoList.filterCompletedItems();
    } else {
      todoList.allItems();
    }
  }

  void _onItemTapped(MenuBottomSelection menuBottomSelection) {
    setState(() {
      menuBottomIndex = menuBottomSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TodoListProvider todoList = Provider.of<TodoListProvider>(context);
    final items = todoList.items;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.todoItem);
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Colors.transparent),
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Finalizados',
          ),
        ],
        currentIndex: menuBottomIndex.index,
        selectedItemColor: Theme.of(context).colorScheme.surface,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        onTap: (index) => _onItemTapped(MenuBottomSelection.values[index]),
      ),
      appBar: AppBar(
        title: const Text('TODO APP'),
        actions: const [
          Icon(
            Icons.date_range,
            size: 30,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 150),
          itemCount: items.length,
          itemBuilder: (context, index) => TodoItem(todo: items[index]),
        ),
      ),
    );
  }
}
