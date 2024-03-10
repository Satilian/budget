import '../common/base_api.dart';
import 'models/models.dart';

class CategoriesApi extends BaseApi {
  Future<List<CategoriesResponse>> find(CategoriesFilter filter) {
    return fetch<CategoriesFilter, List<CategoriesResponse>>(
      HttpMethod.get,
      'categories/find?name=${filter.name}',
      (json) => json['categories']
          .map<CategoriesResponse>((item) => CategoriesResponse.fromJson(item))
          .toList(),
    );
  }
}
