import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/local/expense_local_ds.dart';
import '../datasources/remote/expense_remote_ds.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource local;
  final ExpenseRemoteDataSource remote;

  ExpenseRepositoryImpl({required this.local, required this.remote});

  @override
  Future<void> addExpense(Expense expense) async {
    final model = ExpenseModel(
      id: expense.id,
      title: expense.title,
      amount: expense.amount,
      date: expense.date,
    );
    await local.insertExpense(model);
    await remote.addExpense(model);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await local.deleteExpense(id);
    await remote.deleteExpense(id);
  }

  @override
  Future<List<Expense>> fetchExpenses() async {
    final localData = await local.getExpenses();
    if (localData.isNotEmpty) return localData;
    final remoteData = await remote.fetchExpenses();
    for (final exp in remoteData) {
      await local.insertExpense(exp);
    }
    return remoteData;
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    final model = ExpenseModel(
      id: expense.id,
      title: expense.title,
      amount: expense.amount,
      date: expense.date,
    );
    await local.updateExpense(model);
    await remote.updateExpense(model);
  }
}
