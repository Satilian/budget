// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      login: json['login'] as String,
      createdAt: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'login': instance.login,
      'created': instance.createdAt.toIso8601String(),
    };
