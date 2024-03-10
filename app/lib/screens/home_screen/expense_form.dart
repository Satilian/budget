import 'dart:async';

import 'package:budget/repos/repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../api/api.dart';

class ExpenseForm extends StatefulWidget {
  ExpenseForm({super.key});
  final expenseApi = ExpenseApi();
  final categoriesApi = CategoriesApi();

  @override
  State<ExpenseForm> createState() {
    return _ExpenseFormState();
  }
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onSubmit(Map<String, dynamic> val) {
    context.read<ExpenseRepo>().addExpense(val).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.expense_added)),
      );
      Navigator.pop(context, true);
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка добавления расхода')),
      );
    });
  }

  FutureOr<Iterable<String>> getCatogories(String name) async {
    if (name.isNotEmpty) {
      var res = await widget.categoriesApi.find(CategoriesFilter(name: name));
      if (res.isEmpty) {
        return [name];
      }
      return res.map((e) => e.name);
    } else {
      return [];
    }
  }

  FutureOr<Iterable<String>> getExpenseNames(String name) async {
    if (name.isNotEmpty) {
      var res = await widget.expenseApi.names(ExpenseNamesFilter(name: name));
      if (res.isEmpty) {
        return [name];
      }
      return res.map((e) => e.name);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilder(
          key: _formKey,
          initialValue: const {
            'category': '',
            'expense': '',
            'value': '',
          },
          skipDisabled: true,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              FormBuilderTypeAhead<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Категория',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                name: 'category',
                itemBuilder: (context, country) {
                  return ListTile(title: Text(country));
                },
                controller: TextEditingController(text: ''),
                suggestionsCallback: getCatogories,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Обязательное поле'),
                ]),
              ),
              FormBuilderTypeAhead<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'expense',
                decoration: InputDecoration(
                  labelText: 'Название',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                itemBuilder: (context, country) {
                  return ListTile(title: Text(country));
                },
                controller: TextEditingController(text: ''),
                suggestionsCallback: getExpenseNames,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Обязательное поле'),
                ]),
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'value',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Значение',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Обязательное поле'),
                ]),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  _onSubmit(_formKey.currentState!.value);
                } else {
                  debugPrint(_formKey.currentState?.value.toString());
                  debugPrint('validation failed');
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFF76A777);
                    }
                    return null;
                  },
                ),
              ),
              child: Text(
                "Добавить расход",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
