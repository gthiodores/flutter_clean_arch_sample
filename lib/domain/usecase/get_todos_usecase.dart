import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_sample/domain/model/todo.dart';
import 'package:flutter_clean_arch_sample/domain/repository/todo_repository.dart';

class GetTodos {
  final TodoRepository repository;

  const GetTodos(this.repository);

  Future<Either<Exception, List<Todo>>> execute() {
    return repository.getTodoList();
  }
}
