import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final bool completed;

  const Todo({
    required this.title,
    required this.completed,
  });

  @override
  List<Object?> get props => [title, completed];
}
