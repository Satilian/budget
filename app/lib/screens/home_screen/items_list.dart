import 'dart:developer';

import 'package:budget/api/api.dart';
import 'package:flutter/material.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, this.items = const <ExpenseItem>[]});

  final List<ExpenseItem> items;

  @override
  Widget build(BuildContext context) {
    log(items.toString());
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
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
  }
}
