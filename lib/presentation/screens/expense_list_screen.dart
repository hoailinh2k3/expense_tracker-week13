import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../viewmodels/auth_view_model.dart';
import '../../viewmodels/expense_view_model.dart';
import '../../widgets/expense_item_widget.dart';
import '../../../domain/entities/expense.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ExpenseViewModel>().loadExpenses());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ExpenseViewModel>();
    final auth = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: () async {
              await auth.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: vm.expenses.length,
        itemBuilder: (context, index) {
          final expense = vm.expenses[index];
          return ExpenseItemWidget(
            expense: expense,
            onTap: () async {
              await Navigator.pushNamed(
                context,
                Routes.addEditExpense,
                arguments: expense,
              );
              await vm.loadExpenses();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, Routes.addEditExpense);
          await vm.loadExpenses();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
