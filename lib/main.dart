import 'package:flutter/material.dart';
import 'package:airhost_todo/screens/home_screen.dart';
import 'package:airhost_todo/screens/create_todo_screen.dart';
import 'package:airhost_todo/screens/update_todo_screen.dart';
import 'package:airhost_todo/providers/todo_provider.dart';
import 'package:airhost_todo/services/database_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService.initilize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: 'Air Host Todo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/create_todo': (context) => const CreateTodoScreen(),
          '/update_todo': (context) => const UpdateTodoScreen(),
        },
      ),
    );
  }
}
