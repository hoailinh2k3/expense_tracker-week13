import 'package:flutter/material.dart';

import '../../domain/entities/expense.dart';
import '../../utils/date_time_utils.dart';

class ExpenseItemWidget extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onTap;

  const ExpenseItemWidget({super.key, required this.expense, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text(DateTimeUtils.format(expense.date)),
      trailing: Text('\$'+expense.amount.toStringAsFixed(2)),
      onTap: onTap,
    );
  }
}
