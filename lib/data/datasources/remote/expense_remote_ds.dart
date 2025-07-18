import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/expense_model.dart';

class ExpenseRemoteDataSource {
  final CollectionReference<Map<String, dynamic>> collection;

  ExpenseRemoteDataSource(FirebaseFirestore firestore)
      : collection = firestore.collection('expenses');

  Future<List<ExpenseModel>> fetchExpenses() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map((doc) => ExpenseModel.fromMap({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Future<void> addExpense(ExpenseModel model) async {
    await collection.add(model.toMap());
  }

  Future<void> updateExpense(ExpenseModel model) async {
    await collection.doc(model.id).set(model.toMap());
  }

  Future<void> deleteExpense(String id) async {
    await collection.doc(id).delete();
  }
}
