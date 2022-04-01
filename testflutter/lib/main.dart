import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/database/TodoElement.dart';
import 'package:testflutter/database/TodoList.dart';
import 'package:testflutter/pages/HomePage.dart';
import 'package:testflutter/pages/TodoListPage.dart';
import 'package:testflutter/providers/TodoListModel.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  if(Platform.isWindows) {
    pathProvider.getApplicationDocumentsDirectory();
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }
  Hive.registerAdapter(TodoElementAdapter());
  Hive.registerAdapter(TodoListAdapter());
  await Hive.openBox<TodoList>(MyApp.BOXNAME);
  runApp(ChangeNotifierProvider(
      create: (context) => TodoListModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const BOXNAME = 'todoList';
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
