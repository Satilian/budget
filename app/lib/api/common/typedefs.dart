import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef SuccessCallback = void Function(bool);
typedef LocalizationGetter = String Function(AppLocalizations);

String unknownError(AppLocalizations locale) {
  return locale.errors_unknown;
}
