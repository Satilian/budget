import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'signup_response.g.dart';

@JsonSerializable(includeIfNull: false)
class SignupResponse implements BaseEntity {
  final String id;
  final String email;
  final String login;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const SignupResponse({
    required this.id,
    required this.email,
    required this.login,
    required this.createdAt,
    this.updatedAt,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}
