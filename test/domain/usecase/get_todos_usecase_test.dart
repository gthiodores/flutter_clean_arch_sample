import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_sample/domain/model/todo.dart';
import 'package:flutter_clean_arch_sample/domain/repository/todo_repository.dart';
import 'package:flutter_clean_arch_sample/domain/usecase/get_todos_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late MockTodoRepository mockTodoRepository;
  late GetTodos usecase;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodos(mockTodoRepository);
  });

  test('should return error message on failure', () async {
    when(() => mockTodoRepository.getTodoList())
        .thenAnswer((_) async => Left('error'));

    final result = await usecase.execute();

    result.fold(
      (msg) => expect(msg, 'error'),
      (data) => fail('should not receive data'),
    );
  });

  test('should return a list of todos on success', () async {
    when(() => mockTodoRepository.getTodoList()).thenAnswer(
        (_) async => Right([Todo(title: 'lorem', completed: false)]));

    final result = await usecase.execute();

    result.fold(
      (msg) => fail('should not return error'),
      (data) => expect(data, [Todo(title: 'lorem', completed: false)]),
    );
  });
}
