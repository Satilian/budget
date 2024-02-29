import 'dart:developer';

import 'package:flutter/material.dart';

import '../../api/api.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key, required this.expenseRepository});
  final ExpenseRepository expenseRepository;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  List<ExpenseCategory> items = [];

  @override
  void initState() {
    widget.expenseRepository.fetchCategories().then((value) {
      log('${value.length}');
      setState(() {
        items = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 75, 10, 50),
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
