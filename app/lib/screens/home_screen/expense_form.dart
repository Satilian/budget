import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() {
    return _ExpenseFormState();
  }
}

class _ExpenseFormState extends State<ExpenseForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _categoryHasError = false;
  bool _expenseHasError = false;
  bool _valueHasError = false;

  void _onSubmit(Map<String, dynamic> val) {}

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
          autovalidateMode: AutovalidateMode.disabled,
          skipDisabled: true,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              FormBuilderSearchableDropdown<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'category',
                asyncItems: (filter) async {
                  await Future.delayed(const Duration(seconds: 1));
                  var list = <String>[]
                      .where((element) =>
                          element.toLowerCase().contains(filter.toLowerCase()))
                      .toList();
                  return list.isEmpty ? [filter] : list;
                },
                decoration: InputDecoration(
                  labelText: 'Категория',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: _categoryHasError
                      ? const Icon(Icons.error, color: Colors.red)
                      : const Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    _categoryHasError = !(_formKey
                            .currentState?.fields['category']
                            ?.validate() ??
                        false);
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Обязательное поле'),
                ]),
              ),
              FormBuilderSearchableDropdown<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'expense',
                asyncItems: (filter) async {
                  await Future.delayed(const Duration(seconds: 1));
                  var list = <String>[]
                      .where((element) =>
                          element.toLowerCase().contains(filter.toLowerCase()))
                      .toList();
                  return list.isEmpty ? [filter] : list;
                },
                decoration: InputDecoration(
                  labelText: 'Название',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: _expenseHasError
                      ? const Icon(Icons.error, color: Colors.red)
                      : const Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    _expenseHasError = !(_formKey
                            .currentState?.fields['expense']
                            ?.validate() ??
                        false);
                  });
                },
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
                  suffixIcon: _valueHasError
                      ? const Icon(Icons.error, color: Colors.red)
                      : const Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    _valueHasError =
                        !(_formKey.currentState?.fields['value']?.validate() ??
                            false);
                  });
                },
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
      ],
    );
  }
}
