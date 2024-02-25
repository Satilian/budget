import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 50, // Required: The total number of items in the list
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Theme.of(context).colorScheme.primary);
      },
      itemBuilder: (BuildContext context, int i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('row $i cell 1'),
            Text("row $i cell 2"),
          ],
        );
      },
    );
  }
}
