import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'signin_response.g.dart';

@JsonSerializable(includeIfNull: false)
class SigninResponse implements BaseEntity {
  final String jwt;

  const SigninResponse({required this.jwt});

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}
