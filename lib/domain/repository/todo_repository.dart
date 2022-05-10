import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_sample/domain/model/todo.dart';

abstract class TodoRepository {
  Future<Either<Exception, List<Todo>>> getTodoList();
}
