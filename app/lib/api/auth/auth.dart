import 'package:http/http.dart' as http;

import '../common/base_repository.dart';
import 'models/signup_data.dart';

export 'models/models.dart';

class AuthRepository extends BaseRepository {
  AuthRepository();

  @override
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };

  Future<http.Response> signup(SignupData body) {
    return http.post(
      Uri.parse('https://localhost:8080'),
      headers: defaultHeaders,
      body: body.toJson(),
    );
  }
}
