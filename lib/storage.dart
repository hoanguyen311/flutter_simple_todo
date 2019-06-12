import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import './todo.dart';

class TodoStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    String path = await _localPath;

    return File('$path/todos.txt');
  }

  Future<File> writeTodoList(List<Todo> todos) async {
    final file = await _localFile;
    final List<Map> json = todos.map((todo) => todo.toJson()).toList();

    return file.writeAsString(jsonEncode(json));
  }

  Future<List<Todo>> readTodoList() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      final json = jsonDecode(contents);
      final List<Todo> todos = (json as List).map((json) => Todo.fromJson(json)).toList();

      return todos;
    } catch(e) {
      return <Todo>[];
    }
  }
}