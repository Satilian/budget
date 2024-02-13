import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'signin_data.g.dart';

@JsonSerializable(includeIfNull: false)
class SigninData implements BaseEntity {
  final String login;
  final String pass;

  const SigninData({
    required this.login,
    required this.pass,
  });

  factory SigninData.fromJson(Map<String, dynamic> json) =>
      _$SigninDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SigninDataToJson(this);
}
