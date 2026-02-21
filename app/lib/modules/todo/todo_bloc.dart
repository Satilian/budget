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
    on<AddTodo>(_onAddTodo);
    on<ToggleTodo>(_onToggleTodo);
    on<DeleteTodo>(_onDeleteTodo);

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
        final List<dynamic> decoded = jsonDecode(todosJson);
        final List<TodoItem> items = decoded
            .map((json) => TodoItem.fromJson(json as Map<String, dynamic>))
            .toList();

        emit(state.copyWith(items: items, isLoading: false));
      } else {
        emit(state.copyWith(items: [], isLoading: false));
      }
    } catch (e) {
      // If there's an error loading, start with empty list
      emit(state.copyWith(items: [], isLoading: false));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    final newItem = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      category: event.category,
      expense: event.expense,
      value: event.value,
    );

    final updatedItems = List<TodoItem>.from(state.items)..add(newItem);
    emit(state.copyWith(items: updatedItems));

    await _saveTodos(updatedItems);
  }

  Future<void> _onToggleTodo(ToggleTodo event, Emitter<TodoState> emit) async {
    final updatedItems = state.items.map((item) {
      if (item.id == event.id) {
        return item.copyWith(isCompleted: !item.isCompleted);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
    await _saveTodos(updatedItems);
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    final updatedItems =
        state.items.where((item) => item.id != event.id).toList();

    emit(state.copyWith(items: updatedItems));
    await _saveTodos(updatedItems);
  }

  Future<void> _saveTodos(List<TodoItem> items) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          items.map((item) => item.toJson()).toList();
      final String encoded = jsonEncode(jsonList);

      await _storage.write(key: _storageKey, value: encoded);
    } catch (e) {
      // Handle error silently or log it
    }
  }
}
