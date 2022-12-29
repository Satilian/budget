import 'base_api_error.dart';
import 'models/validation_error.dart';
import 'typedefs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

BaseApiError resolveErrorMessage(Map<String, dynamic> jsonError) {
  var message = unknownError;
  if (jsonError['title']?.toString().toLowerCase().contains('validation') ==
      true) {
    final errorsMap = jsonError['errors'] as Map<String, dynamic>;
    message = (AppLocalizations locale) => locale.validation_default;
    final fieldErrors = Map.fromIterable(
      errorsMap.entries,
      key: (fieldError) => fieldError.key.toString(),
      value: (fieldError) {
        final errorCode = (fieldError.value as List?)?[0]?['errorCode'];
        switch (errorCode) {
          case 'validations.InvalidPhoneRus':
            return (AppLocalizations locale) => locale.validation_invalid_phone;
          default:
            return unknownError;
        }
      },
    );

    return ValidationError(message, fieldErrors: fieldErrors);
  }

  return BaseApiError(message);
}
