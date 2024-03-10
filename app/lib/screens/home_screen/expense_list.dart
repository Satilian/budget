import 'package:budget/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        var items = state.categories;

        return Container(
          margin: const EdgeInsets.fromLTRB(10, 75, 10, 50),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(items[i].name)),
                    SizedBox(width: 100, child: Text('${items[i].value}')),
                  ],
                ),
              );
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
