import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'expense_category.g.dart';

@JsonSerializable(includeIfNull: false)
class ExpenseCategory implements BaseEntity {
  final String id;
  final String name;
  final double value;

  const ExpenseCategory({
    required this.id,
    required this.name,
    required this.value,
  });

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseCategoryToJson(this);
}
