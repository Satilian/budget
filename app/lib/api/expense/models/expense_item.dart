import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'expense_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ExpenseItem implements BaseEntity {
  final String id;
  final String name;
  final double value;

  const ExpenseItem({
    required this.id,
    required this.name,
    required this.value,
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) =>
      _$ExpenseItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseItemToJson(this);
}
