import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'signup_response.g.dart';

@JsonSerializable(includeIfNull: false)
class SignupResponse implements BaseEntity {
  final String id;
  final String accountId;
  final String login;

  @JsonKey(name: 'created')
  final DateTime createdAt;

  const SignupResponse({
    required this.id,
    required this.accountId,
    required this.login,
    required this.createdAt,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}
