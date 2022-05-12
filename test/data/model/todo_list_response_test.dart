import 'package:flutter_clean_arch_sample/data/model/todo_list_response.dart';
import 'package:flutter_clean_arch_sample/data/model/todo_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTodoResponse1 =
      TodoResponse(userId: 1, id: 1, title: 'title', completed: false);
  final tTodoResponse2 =
      TodoResponse(userId: 1, id: 1, title: 'title', completed: true);
  final tTodoListResponse1 = TodoListResponse(todos: [tTodoResponse1]);
  final tTodoListResponse2 = TodoListResponse(todos: [tTodoResponse2]);

  test('should return true when equal', () {
    final result = tTodoListResponse1 == tTodoListResponse1;
    expect(result, true);
  });

  test('should return false when not equal', () {
    final result = tTodoListResponse1 == tTodoListResponse2;
    expect(result, false);
  });
}
