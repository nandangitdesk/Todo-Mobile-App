import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  //
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value;
    });
    db.updateData();
  }

  // Function to save a new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void createNewTask() {
    // Logic to save a new task will go here
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            saveNewTask();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text('Todo App'),
        titleTextStyle: TextStyle(
          color: Colors.deepPurple[800],
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.deepPurple[100],
        elevation: 10,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.deepPurple[800],
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoItem(
            todoText: db.todoList[index][0],
            isChecked: db.todoList[index][1],
            onChanged: (bool? value) {
              checkBoxChanged(value, index);
            },
            onPressed: (context) {
              deleteTask(index);
            },
          );
        },
      ),
    );
  }
}
