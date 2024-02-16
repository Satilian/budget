import '../common/base_repository.dart';
import 'models/models.dart';

class ExpenseRepository extends BaseRepository {
  ExpenseRepository();

  @override
  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json; charset=UTF-8',
      };

  Future<void> addExpense(AddExpenseData body) {
    return fetch<AddExpenseData, void>(
      HttpMethod.post,
      'expense/add',
      (json) => json,
      request: body,
    );
  }
}
