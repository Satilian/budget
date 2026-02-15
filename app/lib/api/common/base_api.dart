import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:budget/repos/repos.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'base_api_error.dart';
import 'base_entity.dart';
import 'typedefs.dart';

typedef ResultFactoryType<T> = T Function(Map<String, dynamic> json);
typedef RequestFactoryType<T> = String Function(T request);

enum HttpMethod { get, post, put, patch, delete }

Type _getType<T>() => T;
final _voidType = _getType<void>();

final String apiUrl =
    'https://${dotenv.env['API_HOST']}:${dotenv.env['API_PORT']}/api/';

abstract class BaseApi {
  static String? accessToken;
  static bool _initialized = false;
  static AuthRepo? authRepo;

  static void setAccessToken(value) {
    const storage = FlutterSecureStorage();

    storage.write(key: 'accessToken', value: value);
    BaseApi.accessToken = value;
  }

  static void removeAccessToken() {
    const storage = FlutterSecureStorage();

    storage.delete(key: 'accessToken');
    BaseApi.accessToken = null;
  }

  static HttpClient client = HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) =>
        host == dotenv.env['API_HOST']);

  final defaultHeaders = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  BaseApi() {
    if (!_initialized) {
      const storage = FlutterSecureStorage();

      storage
          .read(key: "accessToken")
          .then((value) => BaseApi.setAccessToken(value));
      _initialized = true;
    }
  }

  Uri getUrl(String urlPart) {
    return Uri.parse('$apiUrl$urlPart');
  }

  void setHeaders(
    HttpClientRequest request,
    Map<String, String>? appendHeaders,
  ) {
    defaultHeaders.forEach((name, value) {
      request.headers.add(name, value);
    });
    appendHeaders?.forEach((name, value) {
      request.headers.add(name, value);
    });
    request.headers.add('Authorization', '$accessToken');
  }

  String requestFactory<TReq extends BaseEntity>(TReq requestBody) {
    return jsonEncode(requestBody.toJson());
  }

  BaseApiError errorFactory() {
    var message = unknownError;

    return BaseApiError(message);
  }

  Future<TRes> fetch<TReq, TRes>(
    HttpMethod method,
    String url,
    ResultFactoryType<TRes> resultFactory, {
    TReq? request,
    Map<String, String>? headers,
    RequestFactoryType<TReq>? requestFactory,
  }) async {
    final String? body;

    if (request != null) {
      if (requestFactory != null) {
        body = requestFactory(request);
      } else if (request is BaseEntity) {
        // ignore: unnecessary_cast
        body = this.requestFactory(request as BaseEntity);
      } else {
        debugPrint(
            '!WARNING! Type ${request.runtimeType} not extends BaseEntity and no request factory was passed');
        body = null;
      }
    } else {
      body = null;
    }

    late final HttpClientRequest req;
    switch (method) {
      case HttpMethod.get:
        req = await client.getUrl(getUrl(url));
        break;
      case HttpMethod.post:
        req = await client.postUrl(getUrl(url));
        break;
      case HttpMethod.delete:
        req = await client.deleteUrl(getUrl(url));
        break;
      case HttpMethod.put:
        req = await client.putUrl(getUrl(url));
        break;
      case HttpMethod.patch:
        req = await client.patchUrl(getUrl(url));
        break;
    }

    HttpClientResponse? res;
    setHeaders(req, headers);
    if (body != null) req.add(utf8.encode(body));
    try {
      res = await req.close();
    } catch (e) {
      log('request error: ${e.toString()}');
      res = null;
    }

    if (res != null && res.statusCode >= 200 && res.statusCode < 300) {
      if (TRes == _voidType) {
        return resultFactory({});
      } else {
        return resultFactory(
            jsonDecode(await res.transform(utf8.decoder).join()));
      }
    } else {
      if (res?.statusCode == 401) {
        BaseApi.authRepo?.logOut();
      }
      log('response error: ${res?.statusCode} ${res?.toString()}');
      throw errorFactory();
    }
  }
}
