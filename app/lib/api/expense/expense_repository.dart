import '../common/base_repository.dart';
import 'models/models.dart';

class ExpenseRepository extends BaseRepository {
  ExpenseRepository();

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
}
