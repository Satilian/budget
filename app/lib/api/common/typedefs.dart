import 'package:budget/l10n/app_localizations.dart';

typedef SuccessCallback = void Function(bool);
typedef LocalizationGetter = String Function(AppLocalizations);

String unknownError(AppLocalizations locale) {
  return locale.errors_unknown;
}
