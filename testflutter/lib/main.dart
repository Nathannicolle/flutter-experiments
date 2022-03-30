import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/pages/HomePage.dart';
import 'package:testflutter/pages/TodoListPage.dart';
import 'package:testflutter/providers/TodoListModel.dart';
import 'package:testflutter/models/Todo.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoListModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/todos': (context) => const TodoListPage(title: 'Todos')
      },
    );
  }
}
