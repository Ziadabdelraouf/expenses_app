import 'package:expenses_app/widgets/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

//this is the main widget and because it is constantly updated with new items, it must be a stateful widget.
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regestiredExpeses = [
    Expense(
        name: 'expense1',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        name: 'expense2',
        amount: 9.79,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker App!'),
        actions: [
          IconButton(
            onPressed: () {
              //this modal is a new screen that shows an overlay on your screen that is closed on press
              showModalBottomSheet(context: context, builder: (ctx)=>const Text('Modal'));
            },
            icon:const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('chart'),
          Expanded(
            child: ExpensesList(expenses: _regestiredExpeses),
          )
        ],
      ),
    );
  }
}
