import 'package:budget/modules/modules.dart';
import 'package:budget/repos/repos.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(
          create: (context) => AuthRepo(),
        ),
        RepositoryProvider<ExpenseRepo>(
          create: (context) => ExpenseRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
              authRepo: RepositoryProvider.of<AuthRepo>(context),
            ),
          ),
          BlocProvider<ExpenseBloc>(
            create: (BuildContext context) => ExpenseBloc(
              expenseRepo: RepositoryProvider.of<ExpenseRepo>(context),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
