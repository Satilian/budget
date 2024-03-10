import 'dart:async';

import 'package:budget/api/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({expenseRepo}) : super(const ExpenseState()) {
    on<CategoriesLoaded>(_onCategoriesLoaded);

    categoriesSubscription = expenseRepo.categories.listen(
      (items) => add(CategoriesLoaded(items)),
    );
  }

  late StreamSubscription<List<ExpenseCategory>> categoriesSubscription;

  _onCategoriesLoaded(event, emit) {
    return emit(ExpenseState(categories: event.categories));
  }
}
