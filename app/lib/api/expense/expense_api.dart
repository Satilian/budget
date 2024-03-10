import '../common/base_api.dart';
import 'models/models.dart';

class ExpenseApi extends BaseApi {
  ExpenseApi();

  Future<void> addExpense(AddExpenseData body) {
    return fetch<AddExpenseData, void>(
      HttpMethod.post,
      'expense/add',
      (json) => json,
      request: body,
    );
  }

  Future<List<ExpenseCategory>> fetchCategories() {
    return fetch<AddExpenseData, List<ExpenseCategory>>(
      HttpMethod.get,
      'expense/categories',
      (json) => json['expense']
          .map<ExpenseCategory>((item) => ExpenseCategory.fromJson(item))
          .toList(),
    );
  }

  Future<List<ExpenseNamesResponse>> names(ExpenseNamesFilter filter) {
    return fetch<ExpenseNamesFilter, List<ExpenseNamesResponse>>(
      HttpMethod.get,
      'expense/names?name=${filter.name}',
      (json) => json['names']
          .map<ExpenseNamesResponse>(
              (item) => ExpenseNamesResponse.fromJson(item))
          .toList(),
    );
  }
}
