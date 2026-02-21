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
