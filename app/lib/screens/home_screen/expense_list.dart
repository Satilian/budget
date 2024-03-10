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
    final categoryId = state.categoryId;
    final items = state.items;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 75, 10, 50),
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onTap: () {
              context.read<ExpenseBloc>().add(ItemsLoadStart(categories[i].id));
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(categories[i].name)),
                      SizedBox(
                          width: 100, child: Text('${categories[i].value}')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
