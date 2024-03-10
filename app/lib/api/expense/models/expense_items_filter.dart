import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'expense_items_filter.g.dart';

@JsonSerializable(includeIfNull: false)
class ExpenseItemsFilter implements BaseEntity {
  final String categoryId;

  const ExpenseItemsFilter({
    required this.categoryId,
  });

  factory ExpenseItemsFilter.fromJson(Map<String, dynamic> json) =>
      _$ExpenseItemsFilterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseItemsFilterToJson(this);
}
