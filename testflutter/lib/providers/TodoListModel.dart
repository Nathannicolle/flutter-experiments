import 'package:flutter/cupertino.dart';

class TodoListModel extends ChangeNotifier {
  List<String> _todos = List.empty(growable: true);

  addItem(String item) {
    _todos.add(item);
    notifyListeners();
  }

  get todos {
    return _todos;
  }

  getItems(int index) {
    return _todos[index];
  }

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

  /*check(int index) {
    _todos[index].checked = true;
    notifyListeners();
  }*/
}