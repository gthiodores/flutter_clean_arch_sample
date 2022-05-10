part of 'todo_list_bloc.dart';

abstract class TodoListState extends Equatable {
  const TodoListState();
}

class TodoListInitial extends TodoListState {
  @override
  List<Object> get props => [];
}

class TodoListLoading extends TodoListState {
  @override
  List<Object> get props => [];
}

class TodoListHasData extends TodoListState {
  final List<Todo> data;

  const TodoListHasData(this.data);

  @override
  List<Object> get props => [data];
}

class TodoListError extends TodoListState {
  final String message;

  const TodoListError(this.message);

  @override
  List<Object> get props => [message];
}
