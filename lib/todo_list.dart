import 'package:flutter/material.dart';


import 'todo_item.dart';
import 'constants.dart';
import 'utils.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<TodoItem> _todoItems = [];

  void _addTodoItem(TodoItem todoItem) {
    setState(() {
      if (todoItem.isValid()) {
        setState(() {
          _todoItems.add(todoItem);
        });
      }
    });
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Mark "${_todoItems[index]}" as done?',
                  style: TextStyle(color: indigoColor)),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      color: amberColor,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(indigoColor!),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    },
                    child: getTodoText("MARK AS DONE"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(amberColor!),
                    ))
              ]);
        });
  }

  Widget _buildTodoItem(TodoItem todoItem, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: indigoColor,
        child: Icon(Icons.note_alt_rounded, color: amberColor),
      ),
      title: getTodoText(todoItem.title),
      subtitle: getTodoText(todoItem.description),
      trailing: Icon(
        Icons.menu,
        color: indigoColor,
      ),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  Widget? _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
        return const ListTile();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: TextStyle(
            color: indigoColor,
          ),
        ),
        backgroundColor: amberColor,
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        // ignore: prefer_const_constructors
        onPressed: () => _pushAddTodoScreen(),
        tooltip: 'Add task',
        child: Icon(
          Icons.add,
          color: amberColor,
        ),
        backgroundColor: indigoColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notes_rounded,
              color: Colors.indigo,
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.indigo,
            ),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.amber.shade500,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: amberColor,
            title: getTodoText("Add New Task"),
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(TodoItem(title: val, description: val));
              Navigator.pop(context);
            },
            decoration: const InputDecoration(
              hintText: "Enter Something To Do...",
              contentPadding: EdgeInsets.all(16.0),
            ),
          ));
    }));
  }
}