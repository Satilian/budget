part of 'expense_bloc.dart';

class ExpenseState extends Equatable {
  const ExpenseState({
    this.categories = const <ExpenseCategory>[],
    this.items = const <ExpenseItem>[],
    this.categoryId,
  });

  final List<ExpenseCategory> categories;
  final String? categoryId;
  final List<ExpenseItem> items;

  @override
  List<Object> get props => [
        categories,
        items,
        {categoryId: categoryId}
      ];
}
