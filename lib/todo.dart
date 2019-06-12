import 'package:uuid/uuid.dart';

class Todo {
  final String title;
  final String id;
  final bool completed;

  Todo({ this.title, this.completed, this.id });

  Todo.fromTitle(this.title):
      completed = false,
      id = Uuid().v4()
  ;

  static Todo fromTitleStatic(String title) {
    return Todo(
      title: title,
      completed: false, id: Uuid().v4()
    );
  }

  Todo copyWith({ title, completed, id }) {
    return Todo(
      title: title ?? this.title,
      completed: completed ?? this.completed,
      id: id ?? this.id
    );
  }

  Todo.fromJson(Map<String, dynamic> json):
      title = json['title'] as String,
      id = json['id'] as String,
      completed = json['completed'] as bool;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}