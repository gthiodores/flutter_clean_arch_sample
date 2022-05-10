import 'package:flutter_clean_arch_sample/data/model/todo_list_response.dart';
import 'package:flutter_clean_arch_sample/data/model/todo_response.dart';
import 'package:http/http.dart' as http;

abstract class TodoRemoteDataSource {
  Future<List<TodoResponse>> getTodoList();
}

class TodoRemoteDataSourceImpl extends TodoRemoteDataSource {
  final http.Client client;

  TodoRemoteDataSourceImpl(this.client);

  @override
  Future<List<TodoResponse>> getTodoList() async {
    final result = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (result.statusCode == 200) {
      return TodoListResponse.fromJson(result.body).todos;
    } else {
      throw Exception('Failed to get todos');
    }
  }
}
