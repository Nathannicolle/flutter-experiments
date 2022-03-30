import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/models/Todo.dart';
import 'package:testflutter/providers/TodoListModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String itemValue = '';

  Future<String?> addListDialog([String name = '']) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Ajouter une liste'),
        content: Consumer<TodoListModel>(builder: (context, todoList, child) {
          return TextFormField(
              autofocus: true,
              initialValue: (name == '') ? '' : todoList.listNames,
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
                  todoList.addNewList(itemValue );
                  Navigator.pop(context, 'create');
                });
              },
              child: const Text('CREATE'),
            );
          }),
        ],
      ),
    );
  }

  Future<String?> deleteList(String name) {
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
                  todoList.removeList(name);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('First Route'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
                ),
                icon: Icon(Icons.add),
                onPressed: addListDialog,
                label: const Text('Add new to-do list')),
          ),
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            List<String> myLists = todoList.listNames;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: todoList.countList,
                itemBuilder: (context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/todos',
                          arguments: myLists[index]);
                    },
                    leading:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      const Icon(Icons.play_arrow, color: Colors.grey),
                    ]),
                    title: Text(myLists[index] + " (${todoList.getListCount(myLists[index]) })",
                        style: const TextStyle(color: Colors.grey)),
                    dense: false,
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      IconButton(
                          onPressed: () => '',
                          icon: const Icon(Icons.edit, color: Colors.grey)),
                      IconButton(
                          onPressed: () => deleteList(myLists[index]) ,
                          icon: const Icon(Icons.delete, color: Colors.grey))
                    ]),
                  );
                });
          })
        ]));
  }
}
