import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/constants.dart';
import '../../api/api.dart';
import '../../widgets/widgets.dart';
import 'expense_form.dart';
import 'expense_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final expenseApi = ExpenseApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: ExpenseList()),
          AddBtn(
            label: AppLocalizations.of(context)!.expense,
            iconSrc: icons.aim,
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Modal(child: ExpenseForm()),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
