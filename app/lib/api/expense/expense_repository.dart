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
}
