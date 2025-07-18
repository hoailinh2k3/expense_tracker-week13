import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'app.dart';
import 'data/datasources/local/expense_local_ds.dart';
import 'data/datasources/remote/auth_remote_ds.dart';
import 'data/datasources/remote/expense_remote_ds.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/expense_repository_impl.dart';
import 'core/services/auth_service.dart';
import 'viewmodels/auth_view_model.dart';
import 'viewmodels/expense_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final database = await openDatabase(
    join(await getDatabasesPath(), 'expenses.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE expenses(id TEXT PRIMARY KEY, title TEXT, amount REAL, date TEXT)',
      );
    },
    version: 1,
  );

  final authRepository = AuthRepositoryImpl(AuthRemoteDataSource(FirebaseAuth.instance));
  final expenseRepository = ExpenseRepositoryImpl(
    local: ExpenseLocalDataSource(database),
    remote: ExpenseRemoteDataSource(FirebaseFirestore.instance),
  );

  final app = ExpenseApp(
    authViewModel: AuthViewModel(AuthService(authRepository)),
    expenseViewModel: ExpenseViewModel(expenseRepository),
  );

  runApp(app);
}
