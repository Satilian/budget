import 'package:budget/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select((ExpenseBloc bloc) => bloc.state.items);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 2, 10, 2),
      child: Column(
        children: items
            .map(
              (item) => Row(
                children: [
                  Expanded(child: Text(item.name)),
                  SizedBox(
                    width: 100,
                    child: Text(item.value.toStringAsFixed(2)),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
