import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../api/api.dart';
import 'form_buttons.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key, required this.authRepository, this.goToLogin})
      : super(key: key);
  final AuthRepository authRepository;
  final VoidCallback? goToLogin;

  @override
  State<SignupForm> createState() {
    return _SignupFormState();
  }
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _emailHasError = false;
  bool _loginHasError = false;
  bool _passHasError = false;
  bool _passIsVisible = false;

  void _onSubmit(Map<String, dynamic> val) async {
    try {
      await widget.authRepository.signup(SignupData.fromJson(val));
      widget.goToLogin!();
    } catch (err) {
      debugPrint('Signup request failed: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FormBuilder(
          key: _formKey,
          initialValue: const {
            'email': '',
            'login': '',
            'pass': '',
          },
          autovalidateMode: AutovalidateMode.disabled,
          skipDisabled: true,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.always,
                name: 'email',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: _emailHasError
                      ? const Icon(Icons.error, color: Colors.red)
                      : const Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    _emailHasError =
                        !(_formKey.currentState?.fields['email']?.validate() ??
                            false);
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.always,
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
                  FormBuilderValidators.required(),
                ]),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.always,
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
                  FormBuilderValidators.required(),
                ]),
                obscureText: !_passIsVisible,
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
        FormButtons(
          submitLabel: 'Зарегистрировать',
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
