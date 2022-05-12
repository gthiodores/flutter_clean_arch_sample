import 'package:flutter_clean_arch_sample/data/datasource/todo_remote_data_source.dart';
import 'package:flutter_clean_arch_sample/data/model/todo_list_response.dart';
import 'package:flutter_clean_arch_sample/data/model/todo_response.dart';
import 'package:flutter_clean_arch_sample/data/repository/todo_repository_impl.dart';
import 'package:flutter_clean_arch_sample/domain/repository/todo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRemoteDataSource extends Mock implements TodoRemoteDataSource {}

void main() {
  late TodoRemoteDataSource mockDataSource;
  late TodoRepository repository;

  setUp(() {
    mockDataSource = MockTodoRemoteDataSource();
    repository = TodoRepositoryImpl(mockDataSource);
  });

  final tResponse =
      TodoResponse(userId: 1, id: 1, title: 'lorem', completed: false);
  final tResponseList = TodoListResponse(todos: [tResponse]);

  test('should return a list of todo when remote call is successful', () async {
    when(() => mockDataSource.getTodoList())
        .thenAnswer((_) async => tResponseList.todos);

    final result = await repository.getTodoList();
    final expectation =
        tResponseList.todos.map((e) => e.toDomainModel()).toList();

    expect(result.getOrElse(() => []), expectation);
  });

  test('should return an exception when remote call failed', () async {
    when(() => mockDataSource.getTodoList())
        .thenThrow(Exception('Failed to get todos'));

    final result = await repository.getTodoList();

    result.fold(
      (l) => expect(l, 'Failed to get todos'),
      (r) => fail('no data should be received'),
    );
  });
}
