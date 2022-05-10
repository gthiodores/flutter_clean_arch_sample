import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch_sample/injection.dart';
import 'package:flutter_clean_arch_sample/presentation/bloc/todo_list/todo_list_bloc.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoListBloc>(
      create: (context) => TodoListBloc(locator.get())..add(TodoListInit()),
      child: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
      ),
      body: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          if (state is TodoListInitial) {
            return const Center();
          }

          if (state is TodoListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TodoListError) {
            return Center(child: Text(state.message));
          }

          if (state is TodoListHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final item = state.data[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('Completed : ${item.completed}'),
                );
              },
              itemCount: state.data.length,
            );
          }

          return const Center(child: Text('Illegal State'));
        },
      ),
    );
  }
}
