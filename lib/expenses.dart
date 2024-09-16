import 'package:flutter/material.dart';
import 'models/expense.dart';

//this is the main widget and because it is constantly updated with new items, it must be a stateful widget. 
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('chart'),
          Text('expenses list'),
        ],
      ),
    );
  }
}
