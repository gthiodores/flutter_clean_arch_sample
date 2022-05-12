import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_sample/domain/usecase/get_todos_usecase.dart';
import 'package:flutter_clean_arch_sample/presentation/bloc/todo_list/todo_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTodos extends Mock implements GetTodos {}

void main() {
  late GetTodos mockGetTodo;
  late TodoListBloc listBloc;

  setUp(() {
    mockGetTodo = MockGetTodos();
    listBloc = TodoListBloc(mockGetTodo);
  });

  test('should start with TodoListInitial state', () {
    expect(listBloc.state, TodoListInitial());
  });

  blocTest<TodoListBloc, TodoListState>(
    'should emit [loading, has data] when usecase success',
    build: () => listBloc,
    act: (bloc) {
      when(() => mockGetTodo.execute()).thenAnswer((_) async => Right([]));
      bloc.add(TodoListInit());
    },
    expect: () => <TodoListState>[
      TodoListLoading(),
      TodoListHasData([]),
    ],
    verify: (bloc) => verify(() => mockGetTodo.execute()).called(1),
  );

  blocTest<TodoListBloc, TodoListState>(
    'should emit [loading, error] when usecase failed',
    build: () => listBloc,
    act: (bloc) {
      when(() => mockGetTodo.execute()).thenAnswer((_) async => Left('error'));
      bloc.add(TodoListInit());
    },
    expect: () => <TodoListState>[
      TodoListLoading(),
      TodoListError('error'),
    ],
    verify: (bloc) => verify(() => mockGetTodo.execute()).called(1),
  );
}
