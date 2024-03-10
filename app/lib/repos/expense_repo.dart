import 'dart:async';

import 'package:budget/api/api.dart';

class ExpenseRepo {
  final expenseApi = ExpenseApi();
  final _controller = StreamController<List<ExpenseCategory>>();

  Stream<List<ExpenseCategory>> get categories async* {
    yield await expenseApi.fetchCategories();
    yield* _controller.stream;
  }

  Future<void> addExpense(Map<String, dynamic> val) async {
    await expenseApi.addExpense(AddExpenseData.fromJson(val));
    _controller.add(await expenseApi.fetchCategories());
  }

  Future<void> getCategories() async {
    _controller.add(await expenseApi.fetchCategories());
  }

  void dispose() => _controller.close();
}
