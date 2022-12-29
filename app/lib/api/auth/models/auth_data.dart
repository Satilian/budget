import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'auth_data.g.dart';

@JsonSerializable(includeIfNull: false)
class AuthData implements BaseEntity {
  @JsonKey(name: 'access_token')
  final String? accessToken;

  @JsonKey(name: 'expires_in')
  final int? expiresIn;

  @JsonKey(name: 'token_type')
  final String? tokenType;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  final String? scope;

  @JsonKey(name: 'error')
  final String? error;

  @JsonKey(name: 'error_description')
  final String? errorDescription;

  const AuthData({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.refreshToken,
    required this.scope,
    required this.error,
    required this.errorDescription,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
