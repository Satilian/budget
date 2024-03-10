import 'package:json_annotation/json_annotation.dart';

import '../../common/common.dart';

part 'categories_filter.g.dart';

@JsonSerializable(includeIfNull: false)
class CategoriesFilter implements BaseEntity {
  final String name;

  const CategoriesFilter({
    required this.name,
  });

  factory CategoriesFilter.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFilterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoriesFilterToJson(this);
}
