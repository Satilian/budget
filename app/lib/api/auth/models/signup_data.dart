import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'signup_data.g.dart';

@JsonSerializable(includeIfNull: false)
class SignupData implements BaseEntity {
  final String email;
  final String login;
  final String pass;

  const SignupData({
    required this.email,
    required this.login,
    required this.pass,
  });

  factory SignupData.fromJson(Map<String, dynamic> json) =>
      _$SignupDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignupDataToJson(this);
}
