import 'package:sqflite/sqflite.dart';
import '../../models/expense_model.dart';

class ExpenseLocalDataSource {
  final Database db;

  ExpenseLocalDataSource(this.db);

  Future<void> insertExpense(ExpenseModel model) async {
    await db.insert('expenses', model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final maps = await db.query('expenses');
    return maps.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  Future<void> updateExpense(ExpenseModel model) async {
    await db.update('expenses', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  Future<void> deleteExpense(String id) async {
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
