import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter List APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String itemValue = '';

  Future<String?> addItemDialog([int index = -1]) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Ajouter un élément'),
        content: Consumer<TodoListModel>(builder: (context, todoList, child) {
          return TextFormField(
              autofocus: true,
              initialValue: (index == -1) ? '' : todoList.getItems(index).name,
              onChanged: (value) {
                itemValue = value;
              });
        }),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            return TextButton(
              onPressed: () {
                setState(() {
                  todoList.addItem(itemValue);
                  Navigator.pop(context, 'Ok');
                });
              },
              child: const Text('OK'),
            );
          }),
        ],
      ),
    );
  }

  Future<String?> editItem([int indexItem = -1]) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Editer un élément'),
        content: Consumer<TodoListModel>(builder: (context, todoList, child) {
          return Row(children: <Widget>[
            TextFormField(
              initialValue: (indexItem == -1) ? '' : todoList.getItems(indexItem).name,
              onChanged: (value) {
                itemValue = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item',
              ),
            )
          ]);
        }),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            return TextButton(
              onPressed: () {
                todoList.todos[indexItem] = itemValue;
                Navigator.pop(context, 'Edit');
              },
              child: const Text('EDIT'),
            );
          })
        ],
      ),
    );
  }

  Future<String?> deleteItem([int indexItem = -1]) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Supprimer un élément'),
        content: Text('Êtes-vous sûr de vouloir supprimer l\'élement ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            return TextButton(
              onPressed: () {
                setState(() {
                  todoList.remove(indexItem);
                  Navigator.pop(context, 'Delete');
                });
              },
              child: const Text('DELETE', style: TextStyle(color: Colors.red)),
            );
          })
        ],
      ),
    );
  }

  Future<String?> clearAll() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Supprimer l\'ensemble des élément'),
        content: Text('Êtes-vous sûr de vouloir supprimer l\'ensemble des élement ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            return TextButton(
              onPressed: () {
                setState(() {
                  todoList.clear();
                  Navigator.pop(context, 'Clear');
                });
              },
              child: const Text('DELETE ALL', style: TextStyle(color: Colors.red)),
            );
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Stack(children: <Widget>[
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            List<Todo> todos = todoList.todos;
            return ListView.builder(
                itemCount: todoList.todos.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.play_arrow, color: Colors.grey),
                        Checkbox(
                            value: todos[index].checked,
                            onChanged: (value) {
                              todoList.toggleCheck(index);
                            })
                      ]
                    ),
                    title: Text(todoList.todos[index],
                        style: const TextStyle(color: Colors.grey)),
                    dense: false,
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      IconButton(
                          onPressed: () => addItemDialog(index),
                          icon: const Icon(Icons.edit, color: Colors.grey)),
                      IconButton(
                          onPressed: () => deleteItem(index),
                          icon: const Icon(Icons.delete, color: Colors.grey))
                    ]),
                  );
                });
          })
        ]),
        floatingActionButton: Stack(children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: EdgeInsets.all(25.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                    onPressed: addItemDialog)),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child:
                  Consumer<TodoListModel>(builder: (context, todoList, child) {
                return FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.delete),
                    onPressed: () {
                      clearAll();
                    });
              }))
        ])
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
