import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'categories_response.g.dart';

@JsonSerializable(includeIfNull: false)
class CategoriesResponse implements BaseEntity {
  final String id;
  final String name;

  const CategoriesResponse({
    required this.id,
    required this.name,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
