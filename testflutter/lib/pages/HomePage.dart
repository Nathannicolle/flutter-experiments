import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/providers/TodoListModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Consumer<TodoListModel>(builder: (context, todoList, child) {
        List<String> myList = todoList.listNames;
        return ListView.builder(
            itemCount: todoList.countList,
            itemBuilder: (context, int index) {
              return ListTile(
                leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.play_arrow, color: Colors.grey),
                    ]
                ),
                title: Text(myList[index],
                    style: const TextStyle(color: Colors.grey)),
                dense: false,
                trailing:
                Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                      onPressed: () => '',
                      icon: const Icon(Icons.edit, color: Colors.grey)),
                  IconButton(
                      onPressed: () => '',
                      icon: const Icon(Icons.delete, color: Colors.grey))
                ]),
              );
            });
      })
    );
  }
}