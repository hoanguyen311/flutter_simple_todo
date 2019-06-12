import 'package:flutter/material.dart';
import '../todo.dart';
import '../storage.dart';
import './form.dart';

class Home extends StatefulWidget {
  Home({Key key, @required this.storage}) : super(key: key);

  final TodoStorage storage;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();

    widget.storage.readTodoList()
      .then((results) {
        setState(() {
          todos = results;
          loading = false;
        });
    })
        .catchError((Object obj) {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: loading ? _buildSpinner() : _buildList(),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add_circle),
        iconSize: 50,
        color: Colors.blue,
        onPressed: handleAdd
      ),
    );
  }

  Future<Null> handleAdd() async {
    final title = await Navigator.push(context, MaterialPageRoute<String>(
      builder: (context) => NewTodoForm()
    ));
    final newList = [
      ...todos,
      Todo.fromTitleStatic(title)
    ];

    if (title != null) {
      setState(() {
        todos = newList;
      });
    }
    await widget.storage.writeTodoList(newList);
  }

  void updateTodo(Todo updatedTodo) async {
    final newList = todos.map<Todo>((item) {
      if (item.id == updatedTodo.id) {
        return updatedTodo;
      }

      return item;
    }).toList();
    setState(() {
      todos = newList;
    });

    await widget.storage.writeTodoList(todos);
  }

  Widget _buildTodo(Todo todo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Checkbox(value: todo.completed, onChanged: (bool value) async {
          return updateTodo(todo.copyWith(completed: value));
        }),
        title: Text(todo.title),
        key: ObjectKey(todo.id),
      ),
    );
  }

  Widget _buildSpinner() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList() {
    if (todos.isEmpty) {
      return Center(
        child: Text('Your list is empty'),
      );
    }

    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, i) {
          return _buildTodo(todos[i]);
        }
    );
  }
}


