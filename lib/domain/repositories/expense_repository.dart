import '../entities/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> fetchExpenses();
  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);
}
