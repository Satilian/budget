// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseApiResponse<TRes> _$BaseApiResponseFromJson<TRes extends BaseEntity>(
  Map<String, dynamic> json,
  TRes Function(Object? json) fromJsonTRes,
) =>
    BaseApiResponse<TRes>(
      fromJsonTRes(json['result']),
    );

Map<String, dynamic> _$BaseApiResponseToJson<TRes extends BaseEntity>(
  BaseApiResponse<TRes> instance,
  Object? Function(TRes value) toJsonTRes,
) =>
    <String, dynamic>{
      'result': toJsonTRes(instance.result),
    };
