import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';

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
  //passing htis function to on changed parameter in TextField.
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

// a function to check if input is valid
  void _submitExpense() {
    //tryparse if used to turn text to double if possible (if not return null).
    final enteredAmount = double.tryParse(_priceController.text);
    final isInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.isEmpty || isInvalid || _selectedDate == null) {
      //error dialog
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          //to input data(text) from user
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
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
                  onPressed: _submitExpense, child: const Text('save'))
            ],
          )
        ],
      ),
    );
  }
}
