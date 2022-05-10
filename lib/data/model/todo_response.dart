import 'package:flutter_clean_arch_sample/domain/model/todo.dart';

class TodoResponse {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const TodoResponse({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) => TodoResponse(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
      );

  Todo toDomainModel() => Todo(title: title, completed: completed);
}
