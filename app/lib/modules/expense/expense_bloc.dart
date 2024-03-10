import 'dart:async';

import 'package:budget/api/api.dart';
import 'package:budget/repos/repos.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({required this.expenseRepo}) : super(const ExpenseState()) {
    on<CategoriesLoaded>(_onCategoriesLoaded);
    on<ItemsLoadDone>(_onItemsLoadDone);
    on<ItemsLoadStart>(_onItemsLoadStart);

    categoriesSubscription = expenseRepo.categories.listen(
      (items) => add(CategoriesLoaded(items)),
    );
    itemsSubscription = expenseRepo.items.listen(
      (items) => add(ItemsLoadDone(items)),
    );
  }

  final ExpenseRepo expenseRepo;

  late StreamSubscription<List<ExpenseCategory>> categoriesSubscription;
  late StreamSubscription<List<ExpenseItem>> itemsSubscription;

  _onCategoriesLoaded(event, emit) {
    return emit(ExpenseState(categories: event.categories));
  }

  _onItemsLoadStart(event, emit) {
    emit(ExpenseState(
      categories: state.categories,
      categoryId: event.categoryId,
      items: const <ExpenseItem>[],
    ));
    expenseRepo.getItems(ExpenseItemsFilter(categoryId: event.categoryId));
  }

  _onItemsLoadDone(event, emit) {
    return emit(ExpenseState(
      categories: state.categories,
      categoryId: state.categoryId,
      items: event.items,
    ));
  }
}
