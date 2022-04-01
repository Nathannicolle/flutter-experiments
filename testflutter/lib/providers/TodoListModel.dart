import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:testflutter/database/TodoElement.dart';
import 'package:testflutter/database/TodoList.dart';
import 'package:testflutter/main.dart';
import 'package:flutter/widgets.dart';

class TodoListModel extends ChangeNotifier {
  late String activeListName;
  TodoListModel() {
    Box box = Hive.box<TodoList>(MyApp.BOXNAME);

    List<TodoList> lists = box.values.toList().cast();
    lists.forEach((list) {
      myLists[list.name] = list.elements.cast<TodoElement>();
    });
  }
  Map<String, List<TodoElement>> myLists = {};
  List<TodoElement> _todos = List.empty(growable: true); // List.empty(growable: true)

  addItem(String item) {
    TodoElement(item);
    notifyListeners();
  }

  setActiveList(String name) {
    if (myLists.containsKey(name)) {
      activeListName = name;
      _todos = myLists[name] as List<TodoElement>;
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

  TodoElement getItems(int index) {
    if(index == -1) {
      return TodoElement(''); 
    }
    return _todos.elementAt(index);
  }

  getList(String name) {
    return myLists[name];
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

  removeList(String nameList) {
    myLists.removeWhere((index, list) => index == nameList);
    notifyListeners();
  }

  save() async {
    // ToDo sauvegarder activeListName et ses items (myList)
    Box box = Hive.box<TodoList>(MyApp.BOXNAME);
    TodoList list =
    await box.values.firstWhere((element) => element.name == activeListName)
        ?..elements = _todos
        ..save();
  }
}