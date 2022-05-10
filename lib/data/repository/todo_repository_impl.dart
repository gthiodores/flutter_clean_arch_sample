import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_sample/data/datasource/todo_remote_data_source.dart';
import 'package:flutter_clean_arch_sample/domain/model/todo.dart';
import 'package:flutter_clean_arch_sample/domain/repository/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<Todo>>> getTodoList() async {
    try {
      final result = await remoteDataSource.getTodoList();
      final todoList = result.map((e) => e.toDomainModel()).toList();
      return Right(todoList);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
