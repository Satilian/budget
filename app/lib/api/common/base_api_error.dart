import 'typedefs.dart';

class BaseApiError {
  final LocalizationGetter message;

  const BaseApiError(this.message);
}
