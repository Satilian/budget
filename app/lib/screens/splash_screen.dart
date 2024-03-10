import 'package:budget/modules/modules.dart';
import 'package:budget/repos/repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStatus = context.select((AuthBloc bloc) => bloc.state.status);

    switch (authStatus) {
      case AuthStatus.unauthenticated:
        return const AuthScreen();
      case AuthStatus.authenticated:
        context.read<ExpenseRepo>().getCategories();
        return const HomeScreen();
      /* case AuthStatus.unknown:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ); */
      default:
        return const AuthScreen();
    }
  }
}
