part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState({
    this.cards = const <TodoCard>[],
    this.isLoading = false,
  });

  final List<TodoCard> cards;
  final bool isLoading;

  TodoState copyWith({
    List<TodoCard>? cards,
    bool? isLoading,
  }) {
    return TodoState(
      cards: cards ?? this.cards,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [cards, isLoading];
}
