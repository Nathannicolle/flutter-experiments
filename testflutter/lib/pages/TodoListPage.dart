import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/models/Todo.dart';
import 'package:testflutter/providers/TodoListModel.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
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
            List<Todo> todos = todoList.todos;
            return TextButton(
              onPressed: () {
                setState(() {
                  todoList.insertOrUpdate(index, itemValue);
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
    final listName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          title: Text(listName),
        ),

        body: Stack(children: <Widget>[
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            todoList.setActiveList(listName);
            List<Todo> todos = todoList.todos;
            return ListView.builder(
                itemCount: todoList.todos.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    onTap: () {},
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
                    title: Text(todos[index].name,
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