import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/the_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.85),
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: Theme.of(context).cardTheme.margin!.vertical),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (d){
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index])
        ),
    );
  }
}
