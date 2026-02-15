// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get app_title => 'Семейный бюджет';

  @override
  String get auth_login_title => 'Вход';

  @override
  String get auth_register_title => 'Регистрация';

  @override
  String get auth_create_account => 'Создать аккаунт';

  @override
  String get auth_forgot_password => 'Забыли пароль';

  @override
  String get expense => 'Расходы';

  @override
  String get expense_added => 'Расход добавлен';

  @override
  String get errors_unknown => 'Неизвестная ошибка';
}
