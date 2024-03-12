import 'package:budget/modules/expense/expense.dart';
import 'package:budget/modules/modules.dart';
import 'package:budget/screens/home_screen/items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExpenseBloc>().state;
    final categories = state.categories;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 75, 10, 50),
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int i) {
          final active = categories[i].id == state.categoryId;

          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                context.read<ExpenseBloc>().add(
                    active ? ItemsReset() : ItemsLoadStart(categories[i].id));
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      color: active
                          ? Theme.of(context).appBarTheme.foregroundColor
                          : null,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(categories[i].name)),
                        SizedBox(
                            width: 100, child: Text('${categories[i].value}')),
                      ],
                    ),
                  ),
                  active ? const ItemsList() : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
