part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();
}

class TodoListInit extends TodoListEvent {
  @override
  List<Object?> get props => [];
}
