import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'api/auth/auth.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() {
    return _SignupFormState();
  }
}

class _SignupFormState extends State<SignupForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _emailHasError = false;
  bool _loginHasError = false;
  bool _passHasError = false;
  bool _passIsVisible = false;
  final authRepository = AuthRepository();

  var genderOptions = ['Male', 'Female', 'Other'];

  void _onSubmit(Map<String, dynamic> val) {
    debugPrint(val.toString());
    var res = authRepository.signup(SignupData.fromJson(val));
    res.then((value) => debugPrint(value.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Builder Example')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
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
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: _emailHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _emailHasError = !(_formKey
                                  .currentState?.fields['email']
                                  ?.validate() ??
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
                      decoration: InputDecoration(
                        labelText: 'Login',
                        suffixIcon: _loginHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _loginHasError = !(_formKey
                                  .currentState?.fields['login']
                                  ?.validate() ??
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
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: _passIsVisible
                                ? Icon(Icons.visibility,
                                    color: _passHasError
                                        ? Colors.red
                                        : Colors.green)
                                : Icon(Icons.visibility_off,
                                    color: _passHasError
                                        ? Colors.red
                                        : Colors.green),
                            onPressed: () {
                              setState(() {
                                _passIsVisible = !_passIsVisible;
                              });
                            },
                          )),
                      onChanged: (val) {
                        setState(() {
                          _passHasError = !(_formKey
                                  .currentState?.fields['pass']
                                  ?.validate() ??
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          debugPrint(_formKey.currentState?.value.toString());

                          _onSubmit(_formKey.currentState!.value);
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
