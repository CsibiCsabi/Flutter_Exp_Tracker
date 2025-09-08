import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Categories {
  food, travel, gear, other
}

const categoryIcons = {
  Categories.food : Icons.apple_outlined,
  Categories.travel : Icons.flight_takeoff,
  Categories.gear : Icons.sports_tennis,
  Categories.other : Icons.door_sliding,
};

class Expense {
  Expense(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category,
      }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) : expenses = allExpenses.where((i)=> i.category == category).toList();

  final Categories category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;

    for (final element in expenses) {
      sum +=element.amount;
    }

    return sum;
  }
}