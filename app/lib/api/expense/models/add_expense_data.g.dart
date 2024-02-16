// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_expense_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddExpenseData _$AddExpenseDataFromJson(Map<String, dynamic> json) =>
    AddExpenseData(
      category: json['category'] as String,
      expense: json['expense'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$AddExpenseDataToJson(AddExpenseData instance) =>
    <String, dynamic>{
      'category': instance.category,
      'expense': instance.expense,
      'value': instance.value,
    };
