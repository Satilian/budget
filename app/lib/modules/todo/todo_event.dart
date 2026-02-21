part of 'todo_bloc.dart';

sealed class TodoEvent {
  const TodoEvent();
}

final class LoadTodos extends TodoEvent {}

final class AddTodo extends TodoEvent {
  const AddTodo({
    required this.category,
    required this.expense,
    required this.value,
  });

  final String? category;
  final String expense;
  final String? value;
}

final class ToggleTodo extends TodoEvent {
  const ToggleTodo(this.id);

  final String id;
}

final class DeleteTodo extends TodoEvent {
  const DeleteTodo(this.id);

  final String id;
}
