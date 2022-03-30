import 'package:flutter/cupertino.dart';
import 'package:testflutter/models/Todo.dart';
import 'package:flutter/widgets.dart';

class TodoListModel extends ChangeNotifier {
  Map<String, List<Todo>> myLists = {'Mes courses':[Todo(name: 'Eau'), Todo(name: 'Pain')]};
  List<Todo> _todos = List.empty(growable: true); // List.empty(growable: true)

  addItem(String item) {
    Todo(name: item);
    notifyListeners();
  }

  setActiveList(String name) {
    if (myLists.containsKey(name)) {
      _todos = myLists[name] as List<Todo>;
      notifyListeners();
    }
  }

  bool addNewList(String name) {
    if(!myLists.containsKey(name)) {
      myLists[name] = List.empty(growable: true);
      notifyListeners();
      return true;
    }
    return false;
  }

  int? getListCount(String name) {
    return myLists[name]?.length;
  }

  get countList {
    return myLists.length;
  }

  get listNames {
    return myLists.keys.toList();
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