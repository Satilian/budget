import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

export 'todo_bloc.dart';

part 'todo.g.dart';

@JsonSerializable()
class TodoItem extends Equatable {
  final String id;
  final String? category;
  final String expense;
  final String? value;
  final bool isCompleted;

  const TodoItem({
    required this.id,
    this.category,
    required this.expense,
    this.value,
    this.isCompleted = false,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);

  TodoItem copyWith({
    String? id,
    String? category,
    String? expense,
    String? value,
    bool? isCompleted,
  }) {
    return TodoItem(
      id: id ?? this.id,
      category: category ?? this.category,
      expense: expense ?? this.expense,
      value: value ?? this.value,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, category, expense, value, isCompleted];
}

class TodoCard extends Equatable {
  const TodoCard({
    required this.id,
    this.items = const <TodoItem>[],
    this.isExpanded = false,
  });

  final String id;
  final List<TodoItem> items;
  final bool isExpanded;

  TodoCard copyWith({
    String? id,
    List<TodoItem>? items,
    bool? isExpanded,
  }) {
    return TodoCard(
      id: id ?? this.id,
      items: items ?? this.items,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  factory TodoCard.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? const [];
    final items = rawItems
        .map((item) => TodoItem.fromJson((item as Map).cast<String, dynamic>()))
        .toList();

    return TodoCard(
      id: json['id']?.toString() ?? '',
      items: items,
      isExpanded: json['isExpanded'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'isExpanded': isExpanded,
    };
  }

  @override
  List<Object?> get props => [id, items, isExpanded];
}
