import 'package:flutter/material.dart';
import '../domain/entities/expense.dart';
import '../domain/repositories/expense_repository.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  List<Expense> _expenses = [];

  List<Expense> get expenses => List.unmodifiable(_expenses);

  ExpenseViewModel(this.repository);

  Future<void> loadExpenses() async {
    _expenses = await repository.fetchExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await repository.addExpense(expense);
    await loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await repository.updateExpense(expense);
    await loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
    await loadExpenses();
  }
}
