part of 'expense_bloc.dart';

sealed class ExpenseEvent {
  const ExpenseEvent();
}

final class CategoriesLoaded extends ExpenseEvent {
  CategoriesLoaded(this.categories);

  final List<ExpenseCategory> categories;
}
