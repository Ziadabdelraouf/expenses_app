import 'package:expenses_app/models/expense.dart';

import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.name),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryicons[expense.category]),
                    const SizedBox(
                      height: 4,
                      width: 8,
                    ),
                    Text(
                      expense.formattedDate,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
