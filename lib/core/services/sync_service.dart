import '../../data/repositories/expense_repository_impl.dart';

class SyncService {
  final ExpenseRepositoryImpl repository;

  SyncService(this.repository);

  Future<void> sync() async {
    final expenses = await repository.remote.fetchExpenses();
    for (final exp in expenses) {
      await repository.local.insertExpense(exp);
    }
  }
}
