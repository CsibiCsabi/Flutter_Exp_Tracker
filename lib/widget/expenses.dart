import 'dart:io';

import 'package:expense_tracker/widget/add_expense_form.dart';
import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/the_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'roundnet set',
        amount: 100.00,
        date: DateTime.now(),
        category: Categories.gear),
    Expense(
        title: 'fruits',
        amount: 19.99,
        date: DateTime.now(),
        category: Categories.food),
  ];



  void _openOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, // context, that was given by state<> widget, further info in lect 108
      builder: (ctx) => AddExpenseForm(_addExpense), // ctx, that is context of the shoxModalBottomSheet widget,
      );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    int index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Get out of here!'),
        action: SnackBarAction(
          label: 'It was a mistake!',
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          }),
      )
    );
  }

  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (Platform.isIOS){
      print('IOS-en vagy');
    } else
      print('Andriod-on vagy');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sport Event Expense Tracker'),
        // backgroundColor: Colors.blueGrey,
        actions: [IconButton(
          onPressed: _openOverlay,
          icon: const Icon(Icons.add))],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: _registeredExpenses.isEmpty ? const Text("Seems like you don't spend much ;)") : ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,)),
        ],
      ) : Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: _registeredExpenses.isEmpty ? const Text("Seems like you don't spend much ;)") : ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,)),
        ],)
    );
  }
}
