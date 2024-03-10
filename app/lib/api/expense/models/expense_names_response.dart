import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'expense_names_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ExpenseNamesResponse implements BaseEntity {
  final String id;
  final String name;

  const ExpenseNamesResponse({
    required this.id,
    required this.name,
  });

  factory ExpenseNamesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExpenseNamesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpenseNamesResponseToJson(this);
}
