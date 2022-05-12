import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arch_sample/data/model/todo_response.dart';

class TodoListResponse extends Equatable {
  final List<TodoResponse> todos;

  const TodoListResponse({required this.todos});

  factory TodoListResponse.fromJson(String json) => TodoListResponse(
        todos: List<TodoResponse>.from(
          jsonDecode(json).map((e) => TodoResponse.fromJson(e)),
        ),
      );

  @override
  List<Object?> get props => [todos];
}
