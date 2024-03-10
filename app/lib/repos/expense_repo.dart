import 'dart:async';

import 'package:budget/api/api.dart';

class ExpenseRepo {
  final expenseApi = ExpenseApi();
  final _categories = StreamController<List<ExpenseCategory>>();
  final _items = StreamController<List<ExpenseItem>>();

  Stream<List<ExpenseCategory>> get categories async* {
    yield* _categories.stream;
  }

  Stream<List<ExpenseItem>> get items async* {
    yield* _items.stream;
  }

  Future<void> addExpense(Map<String, dynamic> val) async {
    await expenseApi.addExpense(AddExpenseData.fromJson(val));
    await getCategories();
  }

  Future<void> getCategories() async {
    _categories.add(await expenseApi.fetchCategories());
  }

  Future<void> getItems(ExpenseItemsFilter filter) async {
    _items.add(await expenseApi.fetchItems(filter));
  }

  void dispose() {
    _categories.close();
    _items.close();
  }
}
