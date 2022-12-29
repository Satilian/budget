import '../base_api_error.dart';
import '../typedefs.dart';

class ValidationError extends BaseApiError {
  final Map<String, LocalizationGetter>? fieldErrors;

  ValidationError(super.message, {this.fieldErrors});
}
