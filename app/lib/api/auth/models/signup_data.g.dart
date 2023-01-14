// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupData _$SignupDataFromJson(Map<String, dynamic> json) => SignupData(
      email: json['email'] as String,
      login: json['login'] as String,
      pass: json['pass'] as String,
    );

Map<String, dynamic> _$SignupDataToJson(SignupData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'login': instance.login,
      'pass': instance.pass,
    };
