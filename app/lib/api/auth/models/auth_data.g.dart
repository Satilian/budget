// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      tokenType: json['token_type'] as String?,
      refreshToken: json['refresh_token'] as String?,
      scope: json['scope'] as String?,
      error: json['error'] as String?,
      errorDescription: json['error_description'] as String?,
    );

Map<String, dynamic> _$AuthDataToJson(AuthData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('access_token', instance.accessToken);
  writeNotNull('expires_in', instance.expiresIn);
  writeNotNull('token_type', instance.tokenType);
  writeNotNull('refresh_token', instance.refreshToken);
  writeNotNull('scope', instance.scope);
  writeNotNull('error', instance.error);
  writeNotNull('error_description', instance.errorDescription);
  return val;
}
