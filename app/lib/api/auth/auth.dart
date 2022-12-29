import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/common.dart';
import '../common/common.dart';
import 'models/models.dart';

export 'models/models.dart';
import 'package:http/http.dart' as http;

class _AuthGrantTypes {
  static const clientCredentials = "client_credentials";
  static const password = "password";
  static const refreshToken = "refresh_token";
}

class AuthRepository extends BaseRepository {
  AuthRepository();

  @override
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };

  final _storage = const FlutterSecureStorage();

  @override
  BaseApiError errorFactory(http.Response response) {
    var message = unknownError;
    if (response.body.startsWith('{')) {
      final json = jsonDecode(response.body);
      final error = AuthData.fromJson(json);

      if (error.error == 'invalid_grant') {
        if (error.errorDescription == 'BruteforceCooldown') {
          message = (locale) => locale.errors_bruteforce;
        } else if (error.errorDescription == 'invalid credentials') {
          message = (locale) => locale.errors_auth_credentials;
        }
      }
    }

    return BaseApiError(message);
  }

  String authRequestFactory(Map<String, String> requestBody) {
    final List<String> requestLines = [];
    requestBody.forEach((key, value) {
      requestLines.add('$key=${Uri.encodeComponent(value)}');
    });

    return requestLines.join("&");
  }

  Future<String> authorizeDevice() async {
    final res = await fetch(
        HttpMethod.post, '/identity/connect/token', AuthData.fromJson,
        request: {
          "client_id": Constants.authDeviceClientId,
          "client_secret": Constants.authDeviceClientSecret,
          "grant_type": _AuthGrantTypes.clientCredentials,
        },
        requestFactory: authRequestFactory);

    return res.accessToken!;
  }

  Future<String> authorize(String login, String password) async {
    final authData = await fetch(
        HttpMethod.post, '/identity/connect/token', AuthData.fromJson,
        request: {
          "client_id": Constants.authUserClientId,
          "client_secret": Constants.authUserClientSecret,
          "grant_type": _AuthGrantTypes.password,
          "scope": "mobile-api offline_access openid profile",
          "username": login,
          "password": password,
        },
        requestFactory: authRequestFactory);

    BaseRepository.accessToken = authData.accessToken;
    BaseRepository.refreshToken = authData.refreshToken;

    _storage.write(key: "accessToken", value: authData.accessToken);
    _storage.write(key: "refreshToken", value: authData.refreshToken);

    return authData.accessToken!;
  }
}
