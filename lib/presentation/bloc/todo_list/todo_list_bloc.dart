import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arch_sample/domain/model/todo.dart';
import 'package:flutter_clean_arch_sample/domain/usecase/get_todos_usecase.dart';

part 'todo_list_event.dart';

part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final GetTodos usecase;

  TodoListBloc(this.usecase) : super(TodoListInitial()) {
    on<TodoListInit>((event, emit) async {
      emit(TodoListLoading());

      final result = await usecase.execute();

      result.fold(
        (exception) => emit(TodoListError(exception)),
        (data) => emit(TodoListHasData(data)),
      );
    });
  }
}
