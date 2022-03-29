import 'package:flutter/cupertino.dart';
import 'package:testflutter/models/Todo.dart';
import 'package:flutter/widgets.dart';

class TodoListModel extends ChangeNotifier {
  List<Todo> _todos = List.empty(growable: true); // List.empty(growable: true)

  addItem(String item) {
    Todo(name: item);
    notifyListeners();
  }

  get todos {
    return _todos;
  }

  Todo getItems(int index) {
    return _todos[index];
  }

  toggleCheck(int index) {
    if(index != -1) {
      _todos[index].checked = !_todos[index].checked;
      notifyListeners();
    }
  }

  insertOrUpdate(int index, String newValue) {
    if(index == -1) {
      addItem(newValue);
    } else {
      update(index, newValue);
    }
  }

  update(int index, String newValue) {
    _todos[index].name = newValue;
    notifyListeners();
  }

  clear() {
    _todos.clear();
    notifyListeners();
  }
  
  remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}