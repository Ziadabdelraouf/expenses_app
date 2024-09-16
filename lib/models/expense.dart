import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
 // this is a data template that will be used to store data of items.
 // it is not a widget therefor it does not exteend any widget (statless nor stateful).
 // uuid is an id generator that is imported using this command (flutter pub add uuid).

 
const uuid = Uuid();

class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final DateTime date;
  final double amount;
}
