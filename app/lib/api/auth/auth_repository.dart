import '../common/base_repository.dart';
import 'models/models.dart';

class AuthRepository extends BaseRepository {
  AuthRepository();

  @override
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json; charset=UTF-8',
      };

  Future<SignupResponse> signup(SignupData body) {
    return fetch<SignupData, SignupResponse>(
      HttpMethod.post,
      'auth/signup',
      (json) => SignupResponse.fromJson(json),
      request: body,
    );
  }

  Future<SigninResponse> signin(SigninData body) {
    return fetch<SigninData, SigninResponse>(
      HttpMethod.post,
      'auth/signin',
      (json) => SigninResponse.fromJson(json),
      request: body,
    );
  }
}
