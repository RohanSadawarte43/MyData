import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

final List<String> _todoList = <String>[];
final TextEditingController _textFieldController = TextEditingController();

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List',
            style: TextStyle(
              fontSize: 25,
            )),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _textFieldController.clear();
  }

  // Generate list of item widgets
  Widget _buildTodoItem(String title, int index) {
    return Container(
      height: 65,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          elevation: 20,
          color: Colors.grey[850],
          child: Row(children: [
            Container(
              width: 320,
              child: Text(
                _todoList[index],
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                _deleteTodoItem(index);
              },
            ),
          ])),
    );
  }

  Future<AlertDialog> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    int index = 0;
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title, index));
      index = index + 1;
    }
    return _todoWidgets;
  }
}
