import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'signup_form.dart';

void main() async {
  // await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family budget',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF212832),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFBEFF2DB)),
        ),
      ),
      home: const SignupForm(),
    );
  }
}
