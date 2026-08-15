import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodoCard>(_onAddTodoCard);
    on<ToggleTodoCard>(_onToggleTodoCard);
    on<AddTodoItem>(_onAddTodoItem);
    on<ToggleTodoItem>(_onToggleTodoItem);
    on<DeleteTodoItem>(_onDeleteTodoItem);
    on<UpdateTodoValue>(_onUpdateTodoValue);

    // Load todos on initialization
    add(LoadTodos());
  }

  static const String _storageKey = 'todos';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final String? todosJson = await _storage.read(key: _storageKey);

      if (todosJson != null && todosJson.isNotEmpty) {
        final decoded = jsonDecode(todosJson);
        final cards = _decodeCards(decoded);
        emit(state.copyWith(cards: cards, isLoading: false));
      } else {
        emit(state.copyWith(cards: [], isLoading: false));
      }
    } catch (e) {
      // If there's an error loading, start with empty list
      emit(state.copyWith(cards: [], isLoading: false));
    }
  }

  Future<void> _onAddTodoCard(
      AddTodoCard event, Emitter<TodoState> emit) async {
    final newCard = TodoCard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    final updatedCards = List<TodoCard>.from(state.cards)..add(newCard);
    emit(state.copyWith(cards: updatedCards));

    await _saveCards(updatedCards);
  }

  Future<void> _onToggleTodoCard(
      ToggleTodoCard event, Emitter<TodoState> emit) async {
    final updatedCards = state.cards.map((card) {
      if (card.id == event.cardId) {
        return card.copyWith(isExpanded: !card.isExpanded);
      }
      return card;
    }).toList();

    emit(state.copyWith(cards: updatedCards));
    await _saveCards(updatedCards);
  }

  Future<void> _onAddTodoItem(
      AddTodoItem event, Emitter<TodoState> emit) async {
    final newItem = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      category: event.category,
      expense: event.expense,
      value: event.value,
    );

    final updatedCards = state.cards.map((card) {
      if (card.id == event.cardId) {
        final updatedItems = List<TodoItem>.from(card.items)..add(newItem);
        return card.copyWith(items: updatedItems);
      }
      return card;
    }).toList();

    emit(state.copyWith(cards: updatedCards));
    await _saveCards(updatedCards);
  }

  Future<void> _onToggleTodoItem(
      ToggleTodoItem event, Emitter<TodoState> emit) async {
    final updatedCards = state.cards.map((card) {
      if (card.id == event.cardId) {
        final updatedItems = card.items.map((item) {
          if (item.id == event.itemId) {
            return item.copyWith(isCompleted: !item.isCompleted);
          }
          return item;
        }).toList();
        return card.copyWith(items: updatedItems);
      }
      return card;
    }).toList();

    emit(state.copyWith(cards: updatedCards));
    await _saveCards(updatedCards);
  }

  Future<void> _onDeleteTodoItem(
      DeleteTodoItem event, Emitter<TodoState> emit) async {
    final updatedCards = state.cards.map((card) {
      if (card.id == event.cardId) {
        final updatedItems =
            card.items.where((item) => item.id != event.itemId).toList();
        return card.copyWith(items: updatedItems);
      }
      return card;
    }).toList();

    emit(state.copyWith(cards: updatedCards));
    await _saveCards(updatedCards);
  }

  Future<void> _onUpdateTodoValue(
      UpdateTodoValue event, Emitter<TodoState> emit) async {
    final updatedCards = state.cards.map((card) {
      if (card.id == event.cardId) {
        final updatedItems = card.items.map((item) {
          if (item.id == event.itemId) {
            return item.copyWith(value: event.value);
          }
          return item;
        }).toList();
        return card.copyWith(items: updatedItems);
      }
      return card;
    }).toList();

    emit(state.copyWith(cards: updatedCards));
    await _saveCards(updatedCards);
  }

  List<TodoCard> _decodeCards(dynamic decoded) {
    if (decoded is! List) {
      return const <TodoCard>[];
    }

    if (decoded.isEmpty) {
      return const <TodoCard>[];
    }

    final first = decoded.first;
    if (first is Map && first.containsKey('items')) {
      return decoded
          .map((json) =>
              TodoCard.fromJson((json as Map).cast<String, dynamic>()))
          .toList();
    }

    // Backward compatibility for stored flat todo list
    final items = decoded
        .map((json) => TodoItem.fromJson((json as Map).cast<String, dynamic>()))
        .toList();

    return [
      TodoCard(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        items: items,
        isExpanded: false,
      ),
    ];
  }

  Future<void> _saveCards(List<TodoCard> cards) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          cards.map((card) => card.toJson()).toList();
      final String encoded = jsonEncode(jsonList);

      await _storage.write(key: _storageKey, value: encoded);
    } catch (e) {
      // Handle error silently or log it
    }
  }
}
