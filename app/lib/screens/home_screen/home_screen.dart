import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/constants.dart';
import '../../api/api.dart';
import '../../widgets/widgets.dart';
import 'expense_form.dart';
import 'expense_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final expenseRepository = ExpenseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ExpenseList(expenseRepository: expenseRepository),
          ),
          AddBtn(
            label: AppLocalizations.of(context)!.expense,
            iconSrc: icons.aim,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Modal(
                    child: ExpenseForm(expenseRepository: expenseRepository),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
