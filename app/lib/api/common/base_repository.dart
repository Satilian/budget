import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../common/common.dart';
import 'base_api_error.dart';
import 'base_entity.dart';
import 'error_helper.dart';
import 'typedefs.dart';

typedef ResultFactoryType<T> = T Function(Map<String, dynamic> json);
typedef RequestFactoryType<T> = String Function(T request);

enum HttpMethod { get, post, put, patch, delete }

Type _getType<T>() => T;
final _voidType = _getType<void>();

abstract class BaseRepository {
  static String? accessToken;
  static String? refreshToken;
  static bool _initialized = false;
  final defaultHeaders = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  BaseRepository() {
    if (!_initialized) {
      const storage = FlutterSecureStorage();

      storage
          .read(key: "accessToken")
          .then((value) => BaseRepository.accessToken = value);
      storage
          .read(key: "refreshToken")
          .then((value) => BaseRepository.refreshToken = value);
      _initialized = true;
    }
  }

  Uri getUrl(String urlPart) {
    return Uri.parse('${Constants.apiUrl}$urlPart');
  }

  Map<String, String> getHeaders(Map<String, String>? appendHeaders) {
    return appendHeaders != null
        ? (<String, String>{}
          ..addEntries(defaultHeaders.entries)
          ..addEntries(appendHeaders.entries))
        : defaultHeaders;
  }

  String requestFactory<TReq extends BaseEntity>(TReq requestBody) {
    return jsonEncode(requestBody.toJson());
  }

  BaseApiError errorFactory(http.Response response) {
    var message = unknownError;
    if (response.body.startsWith('{')) {
      return resolveErrorMessage(jsonDecode(response.body));
    }

    return BaseApiError(message);
  }

  Future<TRes> fetch<TReq, TRes>(
      HttpMethod method, String url, ResultFactoryType<TRes> resultFactory,
      {TReq? request,
      Map<String, String>? headers,
      RequestFactoryType<TReq>? requestFactory}) async {
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

    http.Response res;
    switch (method) {
      case HttpMethod.get:
        res = await http.get(getUrl(url), headers: getHeaders(headers));
        break;
      case HttpMethod.post:
        res = await http.post(getUrl(url),
            headers: getHeaders(headers), body: body);
        break;
      case HttpMethod.delete:
        res = await http.delete(getUrl(url),
            headers: getHeaders(headers), body: body);
        break;
      case HttpMethod.put:
        res = await http.put(getUrl(url),
            headers: getHeaders(headers), body: body);
        break;
      case HttpMethod.patch:
        res = await http.patch(getUrl(url),
            headers: getHeaders(headers), body: body);
        break;
    }

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (TRes == _voidType) {
        final data = resultFactory({});

        return data;
      } else {
        final Map<String, dynamic> dataMap = jsonDecode(res.body);
        final data = resultFactory(dataMap);

        return data;
      }
    } else {
      debugPrint('raw error text: ${res.body}');
      throw errorFactory(res);
    }
  }
}
