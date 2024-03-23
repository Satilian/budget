import 'dart:async';

import 'package:budget/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepo {
  AuthRepo() {
    BaseApi.authRepo = this;
  }

  final _controller = StreamController<AuthStatus>();
  final authApi = AuthApi();
  final storage = const FlutterSecureStorage();

  Stream<AuthStatus> get status async* {
    var token = await storage.read(key: "accessToken");
    if (token?.isNotEmpty ?? false) yield AuthStatus.authenticated;
    yield* _controller.stream;
  }

  Future<void> logIn(Map<String, dynamic> val) async {
    var response = await authApi.signin(SigninData.fromJson(val));
    BaseApi.setAccessToken(response.jwt);
    _controller.add(AuthStatus.authenticated);
  }

  void logOut() {
    BaseApi.removeAccessToken();
    _controller.add(AuthStatus.unauthenticated);
  }

  void removeUser() {
    authApi.remove().then((value) {
      logOut();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void dispose() => _controller.close();
}
