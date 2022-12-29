import 'package:json_annotation/json_annotation.dart';

import 'base_entity.dart';

part 'base_api_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BaseApiResponse<TRes extends BaseEntity> extends BaseEntity {
  final TRes result;

  BaseApiResponse(this.result);

  factory BaseApiResponse.fromJson(Map<String, dynamic> json,
          TRes Function(Map<String, dynamic> json) resultFromJson) =>
      _$BaseApiResponseFromJson(
          json, (json) => resultFromJson(json as Map<String, dynamic>));

  @override
  Map<String, dynamic> toJson() =>
      _$BaseApiResponseToJson(this, (value) => value.toJson());
}
