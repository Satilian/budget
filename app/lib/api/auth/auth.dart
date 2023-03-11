import '../common/base_repository.dart';
import 'models/signup_data.dart';

export 'models/models.dart';

class AuthRepository extends BaseRepository {
  AuthRepository();

  @override
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json; charset=UTF-8',
      };

  Future<void> signup(SignupData body) {
    return fetch<SignupData, void>(
      HttpMethod.post,
      'auth/signup',
      (json) => json,
      request: body,
    );
  }
}
