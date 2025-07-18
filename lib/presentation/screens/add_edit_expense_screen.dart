import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../viewmodels/expense_view_model.dart';
import '../../../domain/entities/expense.dart';
import '../../utils/date_time_utils.dart';

class AddEditExpenseScreen extends StatefulWidget {
  final Expense? initial;

  const AddEditExpenseScreen({super.key, this.initial});

  @override
  State<AddEditExpenseScreen> createState() => _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initial?.title ?? '');
    _amountController = TextEditingController(
        text: widget.initial?.amount.toString() ?? '');
    _selectedDate = widget.initial?.date ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ExpenseViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Text(DateTimeUtils.format(_selectedDate)),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDate: _selectedDate,
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                  child: const Text('Pick date'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final expense = Expense(
                  id: widget.initial?.id ?? const Uuid().v4(),
                  title: _titleController.text,
                  amount: double.tryParse(_amountController.text) ?? 0,
                  date: _selectedDate,
                );
                if (widget.initial == null) {
                  await vm.addExpense(expense);
                } else {
                  await vm.updateExpense(expense);
                }
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
