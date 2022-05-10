import 'package:flutter_clean_arch_sample/data/datasource/todo_remote_data_source.dart';
import 'package:flutter_clean_arch_sample/data/repository/todo_repository_impl.dart';
import 'package:flutter_clean_arch_sample/domain/repository/todo_repository.dart';
import 'package:flutter_clean_arch_sample/domain/usecase/get_todos_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // Http Client
  locator.registerLazySingleton<http.Client>(() => http.Client());

  // Remote data source
  locator.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(locator.get()),
  );

  // Repository
  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(locator.get()),
  );

  // Use case
  locator.registerFactory(() => GetTodos(locator.get()));
}
