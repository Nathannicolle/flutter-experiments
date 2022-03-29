import 'package:flutter/cupertino.dart';
import 'package:testflutter/models/Todo.dart';

class TodoListModel extends ChangeNotifier {
  List<String> _todos = List.empty(growable: true);
  bool checked = false;

  addItem(String item) {
    _todos.add(item);
    notifyListeners();
  }

  get todos {
    return _todos;
  }

  /*Todo getItems(int index) {
    if(index == -1) {
      return Todo(name: '');
    }
    return _todos.elementAt(index);
  }

  toggleCheck(int index) {
    if(index != -1) {
      _todos[index].checked = !_todos[index].checked;
      notifyListeners();
    }
  }*/

  insertOrUpdate(int index, String newValue) {
    if(index == -1) {
      addItem(newValue);
    } else {
      update(index, newValue);
    }
  }

  update(int index, String newValue) {
    _todos[index] = newValue;
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