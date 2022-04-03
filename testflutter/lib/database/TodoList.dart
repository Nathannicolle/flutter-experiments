import 'package:hive/hive.dart';
import 'package:testflutter/database/TodoElement.dart';

part 'TodoList.g.dart';

@HiveType(typeId: 1)
class TodoList extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late List<TodoElement> elements = List<TodoElement>.empty(growable: true);
}