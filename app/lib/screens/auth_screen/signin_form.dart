import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../api/api.dart';
import 'form_buttons.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key, required this.authRepository});
  final AuthRepository authRepository;

  @override
  State<SigninForm> createState() {
    return _SigninFormState();
  }
}

class _SigninFormState extends State<SigninForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loginHasError = false;
  bool _passHasError = false;
  bool _passIsVisible = false;

  void _onSubmit(Map<String, dynamic> val) {
    widget.authRepository.signin(SigninData.fromJson(val)).then((value) {
      BaseRepository.setAccessToken(value.jwt);
      const snackBar = SnackBar(content: Text('Signin complet'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((err) {
      var snackBar = SnackBar(content: Text('Signin request failed: $err'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilder(
          key: _formKey,
          initialValue: const {
            'login': '',
            'pass': '',
          },
          autovalidateMode: AutovalidateMode.disabled,
          skipDisabled: true,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'login',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Login',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: _loginHasError
                      ? const Icon(Icons.error, color: Colors.red)
                      : const Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    _loginHasError =
                        !(_formKey.currentState?.fields['login']?.validate() ??
                            false);
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Обязательное поле'),
                ]),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'pass',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: IconButton(
                    icon: _passIsVisible
                        ? Icon(Icons.visibility,
                            color: _passHasError ? Colors.red : Colors.green)
                        : Icon(Icons.visibility_off,
                            color: _passHasError ? Colors.red : Colors.green),
                    onPressed: () {
                      setState(() {
                        _passIsVisible = !_passIsVisible;
                      });
                    },
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    _passHasError =
                        !(_formKey.currentState?.fields['pass']?.validate() ??
                            false);
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Обязательное поле'),
                ]),
                obscureText: !_passIsVisible,
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
        FormButtons(
          submitLabel: 'Вход',
          onSubmit: () {
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              _onSubmit(_formKey.currentState!.value);
            } else {
              debugPrint(_formKey.currentState?.value.toString());
              debugPrint('validation failed');
            }
          },
          onReset: () {
            _formKey.currentState?.reset();
          },
        ),
      ],
    );
  }
}
