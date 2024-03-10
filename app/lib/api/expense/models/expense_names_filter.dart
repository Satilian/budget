import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'expense_names_filter.g.dart';

@JsonSerializable(includeIfNull: false)
class ExpenseNamesFilter implements BaseEntity {
  final String name;

  const ExpenseNamesFilter({
    required this.name,
  });

  factory ExpenseNamesFilter.fromJson(Map<String, dynamic> json) =>
      _$ExpenseNamesFilterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseNamesFilterToJson(this);
}
