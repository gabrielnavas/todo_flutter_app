import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
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
  }

  Future<List<Todo>> _loadTodos() async {
    final TodoListProvider todoList = Provider.of<TodoListProvider>(
      context,
      listen: false,
    );
    if (menuBottomIndex == MenuBottomSelection.completed) {
      await todoList.filterCompletedItems();
    } else {
      await todoList.allItems();
    }

    return todoList.items;
  }

  void _onItemTapped(MenuBottomSelection menuBottomSelection) {
    setState(() {
      menuBottomIndex = menuBottomSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TodoListProvider>(context);

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
            icon: Icon(Icons.list),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
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
          child: FutureBuilder(
            future: _loadTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Center(
                      child: Text('Carregando Tarefas.'),
                    ),
                  ],
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Adicione uma tarefa!'),
                );
              }

              final List<Todo> items = snapshot.data as List<Todo>;

              if (items.isEmpty) {
                return const Center(
                  child: Text('Adicione uma tarefa!'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 150),
                itemCount: items.length,
                itemBuilder: (context, index) => TodoItem(todo: items[index]),
              );
            },
          )),
    );
  }
}
