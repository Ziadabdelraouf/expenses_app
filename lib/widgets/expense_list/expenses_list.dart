import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expense_list/expenses_item.dart';
import 'package:flutter/material.dart';

// this file is to manage the output of the list to the screen, could be done in expenses.dart but to keep thigs simple we made a seperate widget.
//also we used the listview.builder because the length of the list could get pretty long and would be intensive tasks and
// a singe screen would not be able to have all the list included (instead of column)

//this syntax is used instead of an anonymus function that only return smth without any additional logic.
//before the arrow is the imported data and after it id the returned.
//(context, index) => Text(expenses[index].name)

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.expenses, required this.remove, super.key});

  final List<Expense> expenses;
  final void Function(Expense) remove;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          color: Colors.red,
        ),
        key: ValueKey(
          expenses[index],
        ),
        onDismissed: (direction) {
          remove(
            expenses[index],
          );
        },
        child: ExpensesItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
