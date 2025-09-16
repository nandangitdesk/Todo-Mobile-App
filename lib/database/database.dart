import 'package:hive_flutter/adapters.dart';

class TodoDatabase {
  List todoList = [];

  final _myBox = Hive.box('mybox');

  void createData() {
    todoList = [
      ["Make tutorial", false],
      ["Do exercise", false],
    ];
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
