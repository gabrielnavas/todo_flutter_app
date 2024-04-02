import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoListProvider(),
      child: MaterialApp(
        title: 'Todo App',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xff9395D3),
            onPrimary: Color(0xff9395D3),
            onSecondary: Color.fromARGB(120, 147, 149, 211),
            secondary: Color.fromARGB(120, 147, 149, 211),
            error: Colors.redAccent,
            onError: Color.fromARGB(170, 255, 82, 82),
            background: Color.fromARGB(120, 147, 149, 211),
            onBackground: Color.fromARGB(120, 147, 149, 211),
            surface: Color.fromARGB(50, 147, 149, 211),
            onSurface: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Color(0xff9395D3),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            bodySmall: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          listTileTheme: const ListTileThemeData(
            textColor: Color(0xff9395D3),
            iconColor: Color(0xff9395D3),
            titleAlignment: ListTileTitleAlignment.center,
          ),
        ),
        routes: Routes.routes(),
        home: const TodoListScreen(),
      ),
    );
  }
}
