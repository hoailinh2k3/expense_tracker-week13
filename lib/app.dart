import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/routes.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/expense_list_screen.dart';
import 'presentation/screens/add_edit_expense_screen.dart';
import 'domain/entities/expense.dart';
import 'presentation/theme.dart';
import 'viewmodels/auth_view_model.dart';
import 'viewmodels/expense_view_model.dart';

class ExpenseApp extends StatelessWidget {
  final AuthViewModel authViewModel;
  final ExpenseViewModel expenseViewModel;

  const ExpenseApp({super.key, required this.authViewModel, required this.expenseViewModel});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authViewModel),
        ChangeNotifierProvider.value(value: expenseViewModel),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.login,
        routes: {
          Routes.login: (_) => const LoginScreen(),
          Routes.register: (_) => const RegisterScreen(),
          Routes.expenses: (_) => const ExpenseListScreen(),
          Routes.addEditExpense: (context) {
            final expense = ModalRoute.of(context)!.settings.arguments as Expense?;
            return AddEditExpenseScreen(initial: expense);
          },
        },
      ),
    );
  }
}
