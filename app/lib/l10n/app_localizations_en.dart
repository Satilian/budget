// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Family budget';

  @override
  String get auth_login_title => 'Authorization';

  @override
  String get auth_register_title => 'Registration';

  @override
  String get auth_create_account => 'Create account';

  @override
  String get auth_forgot_password => 'Forgot password';

  @override
  String get expense => 'Expense';

  @override
  String get expense_added => 'Expense added';

  @override
  String get errors_unknown => 'Unknown error';
}
