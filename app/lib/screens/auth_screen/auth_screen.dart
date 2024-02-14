import 'package:budget/screens/auth_screen/signup_form.dart';
import 'package:flutter/material.dart';

import '../../api/api.dart';
import 'signin_form.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  final authRepository = AuthRepository();

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                _isLoginForm ? 'Вход' : 'Регистрация',
                style: const TextStyle(fontSize: 26),
              ),
            ),
            _isLoginForm
                ? SigninForm(authRepository: widget.authRepository)
                : SignupForm(
                    authRepository: widget.authRepository,
                    goToLogin: () {
                      setState(() {
                        _isLoginForm = true;
                      });
                    },
                  ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isLoginForm = !_isLoginForm;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(_isLoginForm ? 'Перейти к регистрация' : 'Вход'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
