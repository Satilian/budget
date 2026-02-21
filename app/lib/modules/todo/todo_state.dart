part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState({
    this.items = const <TodoItem>[],
    this.isLoading = false,
  });

  final List<TodoItem> items;
  final bool isLoading;

  TodoState copyWith({
    List<TodoItem>? items,
    bool? isLoading,
  }) {
    return TodoState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [items, isLoading];
}
