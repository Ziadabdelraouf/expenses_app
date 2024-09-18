import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
// this is a data template that will be used to store data of items.
// it is not a widget therefor it does not exteend any widget (statless nor stateful).

// uuid is an id generator that is imported using this command (flutter pub add uuid).
const uuid = Uuid();

//intl is a date maniplator package that could be added by (flutter pub add intl)
final formatter = DateFormat.yMd();

// a set of predefined categories(enum).
enum Category { food, travel, work, leisure }

const categoryicons = {
  Category.work: Icons.work_history_rounded,
  Category.food: Icons.fastfood_outlined,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
};

class Expense {
  Expense(
      {required this.name,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String name;
  final DateTime date;
  final double amount;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
