import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'add_expense_data.g.dart';

@JsonSerializable(includeIfNull: false)
class AddExpenseData implements BaseEntity {
  final String category;
  final String expense;
  final double value;

  const AddExpenseData({
    required this.category,
    required this.expense,
    required this.value,
  });

  factory AddExpenseData.fromJson(Map<String, dynamic> json) {
    var nextJson = Map<String, dynamic>.from(json);
    nextJson['value'] = double.parse(json['value'].replaceAll(',', '.'));
    return _$AddExpenseDataFromJson(nextJson);
  }

  @override
  Map<String, dynamic> toJson() => _$AddExpenseDataToJson(this);
}
