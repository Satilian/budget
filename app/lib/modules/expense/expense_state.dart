part of 'expense_bloc.dart';

class ExpenseState extends Equatable {
  const ExpenseState({
    this.categories = const <ExpenseCategory>[],
  });

  final List<ExpenseCategory> categories;

  @override
  List<Object> get props => [categories];
}
