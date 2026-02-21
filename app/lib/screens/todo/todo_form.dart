import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../api/api.dart';
import '../../utils/utils.dart';

class TodoForm extends StatefulWidget {
  TodoForm({super.key});

  final expenseApi = ExpenseApi();
  final categoriesApi = CategoriesApi();

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onSubmit(Map<String, dynamic> val) {
    Log.s(val.toString());

    Navigator.pop(context, val);
  }

  FutureOr<List<String>> getCategories(String name) async {
    if (name.isNotEmpty) {
      var res = await widget.categoriesApi.find(CategoriesFilter(name: name));
      if (res.isEmpty) {
        return [name];
      }
      return res.map((e) => e.name).toList();
    } else {
      return [];
    }
  }

  FutureOr<List<String>> getExpenseNames(String name) async {
    if (name.isNotEmpty) {
      var res = await widget.expenseApi.names(ExpenseNamesFilter(name: name));
      if (res.isEmpty) {
        return [name];
      }
      return res.map((e) => e.name).toList();
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
                name: 'category',
                decoration: InputDecoration(
                  labelText: 'Категория',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                itemBuilder: (context, category) {
                  return ListTile(title: Text(category));
                },
                controller: TextEditingController(text: ''),
                suggestionsCallback: getCategories,
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
                itemBuilder: (context, title) {
                  return ListTile(title: Text(title));
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
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return const Color(0xFF76A777);
                    }
                    return null;
                  },
                ),
              ),
              child: Text(
                'Добавить задачу',
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
