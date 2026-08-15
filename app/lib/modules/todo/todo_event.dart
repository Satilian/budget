part of 'todo_bloc.dart';

sealed class TodoEvent {
  const TodoEvent();
}

final class LoadTodos extends TodoEvent {}

final class AddTodoCard extends TodoEvent {}

final class ToggleTodoCard extends TodoEvent {
  const ToggleTodoCard(this.cardId);

  final String cardId;
}

final class AddTodoItem extends TodoEvent {
  const AddTodoItem({
    required this.cardId,
    required this.category,
    required this.expense,
    required this.value,
  });

  final String cardId;
  final String? category;
  final String expense;
  final String? value;
}

final class ToggleTodoItem extends TodoEvent {
  const ToggleTodoItem({
    required this.cardId,
    required this.itemId,
  });

  final String cardId;
  final String itemId;
}

final class DeleteTodoItem extends TodoEvent {
  const DeleteTodoItem({
    required this.cardId,
    required this.itemId,
  });

  final String cardId;
  final String itemId;
}

final class UpdateTodoValue extends TodoEvent {
  const UpdateTodoValue({
    required this.cardId,
    required this.itemId,
    required this.value,
  });

  final String cardId;
  final String itemId;
  final String value;
}
