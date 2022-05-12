import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch_sample/domain/model/todo.dart';
import 'package:flutter_clean_arch_sample/presentation/bloc/todo_list/todo_list_bloc.dart';
import 'package:flutter_clean_arch_sample/presentation/page/todo_list_page.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTodoListBloc extends MockBloc<TodoListEvent, TodoListState>
    implements TodoListBloc {}

void main() {
  late TodoListBloc todoListBloc;

  setUp(() {
    todoListBloc = MockTodoListBloc();
  });

  tearDown(() {
    todoListBloc.close();
  });

  Widget _testableWidget() {
    return BlocProvider.value(
      value: todoListBloc,
      child: MaterialApp(
        home: TodoListScreen(),
      ),
    );
  }

  testWidgets('should display a list of todos when fetching successful',
      (WidgetTester tester) async {
    final initialState =
        TodoListHasData([Todo(title: 'lorem', completed: false)]);

    whenListen<TodoListState>(
      todoListBloc,
      Stream.fromIterable([initialState]),
      initialState: initialState,
    );

    await tester.pumpWidget(_testableWidget());

    final finder = find.byType(ListView);

    expect(finder, findsOneWidget);
  });

  testWidgets('should display an error message when fetching failed',
      (WidgetTester tester) async {
    final initialState = TodoListError('error');

    whenListen<TodoListState>(
      todoListBloc,
      Stream.fromIterable([initialState]),
      initialState: initialState,
    );

    await tester.pumpWidget(_testableWidget());

    final finder = find.byType(Center);
    final textMatcher = find.text('error');

    expect(finder, findsOneWidget);
    expect(textMatcher, findsOneWidget);
  });
}
