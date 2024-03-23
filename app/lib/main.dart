import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'modules/provider.dart';
import 'screens/screens.dart';
import 'theme/theme.dart';

void main() async {
  await dotenv.load(fileName: kDebugMode ? '.env.dev' : '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        title: 'Family budget',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: theme,
        home: const SplashScreen(),
      ),
    );
  }
}
