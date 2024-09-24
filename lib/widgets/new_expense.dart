import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';

//provide platform class used in line 60
import 'dart:io';
//cupertino => ios.
import 'package:flutter/cupertino.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.saveExpense, {super.key});
  final void Function(Expense) saveExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // this may be used but is not convient while having multiple input paarameters.
  // var _enteredtitle = '';
  
  //passing this function to on changed parameter in TextField.
  // void _saveTitleInput(String inputValue) {
  //   _enteredtitle = inputValue;
  // }

//this controller is built in flutter that controlls all the inputs and store it and can later be used to print.
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

//intialized and non intialized
  DateTime? _selectedDate;
  Category _selectedcategory = Category.leisure;

  // gets rid of the conrollers(same as delete in c++)
  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

//async has to be used as showdatepicker return a value of future so we must use (async and await)
  void _datePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(
        DateTime.now().year - 1,
        DateTime.now().month,
        DateTime.now().day,
      ),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isAndroid)
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 26,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'invalid data input!',
                style: TextStyle(
                    // color: Colors.red,
                    ),
              ),
            ],
          ),
          content: const Text(
              'Please make sure you entered valid price,title and date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Okay',
              ),
            )
          ],
        ),
      );
    else
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 26,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'invalid data input!',
                style: TextStyle(
                    // color: Colors.red,
                    ),
              ),
            ],
          ),
          content: const Text(
              'Please make sure you entered valid price,title and date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Okay',
              ),
            )
          ],
        ),
      );
  }

// a function to check if input is valid
  void _submitExpense() {
    //tryparse if used to turn text to double if possible (if not return null).
    final enteredAmount = double.tryParse(_priceController.text);
    final isInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.isEmpty || isInvalid || _selectedDate == null) {
      //error dialog
_showDialog();
      return;
    }
    Navigator.pop(context);
    widget.saveExpense(
      Expense(
          amount: double.parse(_priceController.text),
          category: _selectedcategory,
          date: _selectedDate!,
          name: _titleController.text),
    );
  }

//instead of all these copy and pasting of if else we could have made seperate widgets but im just مكسل
  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constrains) {
        final width = constrains.maxWidth;
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, keyboardspace + 16),
              child: Column(
                children: [
                  //to input data(text) from user
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        Expanded(
                          //to input data (numbers) drom the user
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text('Price'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text('Title')),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedcategory,
                          items: Category.values
                              .map(
                                //maps a list values to list of obejcts to display them in drop down menu
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedcategory = value;
                            });
                          },
                        ),
                        Expanded(
                          child: Row(
                            //push elemnts to the end of the row
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(_selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : 'Select Date'),
                              IconButton(
                                onPressed: _datePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          //to input data (numbers) drom the user
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text('Price'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        // used expanded to prevent problems when a row is inside a row and these thimgs
                        Expanded(
                          child: Row(
                            //push elemnts to the end of the row
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(_selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : 'Select Date'),
                              IconButton(
                                onPressed: _datePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                            onPressed: _submitExpense,
                            child: const Text('save'))
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedcategory,
                          items: Category.values
                              .map(
                                //maps a list values to list of obejcts to display them in drop down menu
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedcategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpense,
                          child: const Text('save'),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
