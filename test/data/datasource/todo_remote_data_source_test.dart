import 'package:flutter_clean_arch_sample/data/datasource/todo_remote_data_source.dart';
import 'package:flutter_clean_arch_sample/data/model/todo_list_response.dart';
import 'package:flutter_clean_arch_sample/data/model/todo_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client mockClient;
  late TodoRemoteDataSource dataSource;

  final tResponse =
      TodoResponse(userId: 1, id: 1, title: 'lorem', completed: false);
  final tResponseList = TodoListResponse(todos: [tResponse]);
  final tJson =
      '[{"userId": 1, "id": 1, "title": "lorem", "completed": false}]';

  setUp(() {
    mockClient = MockHttpClient();
    dataSource = TodoRemoteDataSourceImpl(mockClient);
  });

  test('should return a list of todo response when network code is 200',
      () async {
    when(() => mockClient
            .get(Uri.parse('https://jsonplaceholder.typicode.com/todos')))
        .thenAnswer((_) async => http.Response(tJson, 200));

    final result = await dataSource.getTodoList();

    expect(result, tResponseList.todos);
  });

  test('should throw an exception when network code is not 200', ()  {
    when(() => mockClient
            .get(Uri.parse('https://jsonplaceholder.typicode.com/todos')))
        .thenAnswer((_) async => http.Response('not connected', 404));

    final call = dataSource.getTodoList();

    expect(() => call, throwsException);
  });
}
