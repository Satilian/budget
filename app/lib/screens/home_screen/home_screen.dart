import 'package:budget/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:budget/l10n/app_localizations.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';
import 'expense_form.dart';
import 'expense_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const UserMenu()),
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
