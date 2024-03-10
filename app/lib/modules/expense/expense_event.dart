part of 'expense_bloc.dart';

sealed class ExpenseEvent {
  const ExpenseEvent();
}

final class CategoriesLoaded extends ExpenseEvent {
  CategoriesLoaded(this.categories);

  final List<ExpenseCategory> categories;
}

final class ItemsLoadStart extends ExpenseEvent {
  ItemsLoadStart(this.categoryId);

  final String categoryId;
}

final class ItemsLoadDone extends ExpenseEvent {
  ItemsLoadDone(this.items);

  final List<ExpenseItem> items;
}
